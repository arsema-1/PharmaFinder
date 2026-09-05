import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/foundation.dart';
import '../services/appwrite_service.dart';

class AuthViewModel {
  final Account _account = AppwriteService().account;
  final Databases _databases = AppwriteService().databases;

  bool isLoading = false;
  String? errorMessage;
  models.User? currentUser;

  // ── helpers ──────────────────────────────────────────────────────────────

  /// Saves a user profile document to the `users` collection.
  Future<void> _saveUserProfile({
    required String userId,
    required String name,
    required String email,
    required String role,
    String? phone,
  }) async {
    await _databases.createDocument(
      databaseId: AppwriteService.databaseId,
      collectionId: AppwriteService.usersCol,
      documentId: userId, // use auth userId so lookups are O(1)
      data: {
        'userId': userId,
        'name': name,
        'email': email,
        'phone': phone ?? '',
        'role': role, // 'customer' | 'pharmacist'
        'createdAt': DateTime.now().toIso8601String(),
      },
    );
  }

  // ── public API ────────────────────────────────────────────────────────────

  /// Register + save role. Used by both customer signup and pharmacy step-1.
  Future<bool> createAccountWithRole({
    required String name,
    required String email,
    required String password,
    required String role, // 'customer' | 'pharmacist'
    String? phone,
  }) async {
    isLoading = true;
    errorMessage = null;

    try {
      // Clear any existing session before creating a new account
      try {
        await _account.deleteSession(sessionId: 'current');
      } catch (_) {
        // No active session — that's fine
      }

      final userId = ID.unique();

      // Step 1: create auth account
      await _account.create(
        userId: userId,
        email: email,
        password: password,
        name: name,
      );

      // Step 2: create session
      await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      currentUser = await _account.get();

      // Step 3: save profile to database
      try {
        await _saveUserProfile(
          userId: currentUser!.$id,
          name: name,
          email: email,
          role: role,
          phone: phone,
        );
      } on AppwriteException catch (e) {
        // Auth account created successfully — just log the DB error
        // so registration still proceeds rather than showing a false failure
        debugPrint('DB profile save failed: [${e.code}] ${e.message}');
      }

      isLoading = false;
      return true;
    } on AppwriteException catch (e) {
      debugPrint('Auth error: [${e.code}] ${e.message}');
      errorMessage = e.message ?? 'Registration failed. Please try again.';
      isLoading = false;
      return false;
    } catch (e) {
      debugPrint('Unexpected registration error: $e');
      errorMessage = 'An unexpected error occurred: $e';
      isLoading = false;
      return false;
    }
  }

  /// Create a new account without auto-login (legacy – kept for compatibility)
  Future<bool> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;

    try {
      await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      isLoading = false;
      return true;
    } on AppwriteException catch (e) {
      errorMessage = e.message ?? 'Account creation failed. Please try again.';
      isLoading = false;
      return false;
    } catch (e) {
      errorMessage = 'An unexpected error occurred.';
      isLoading = false;
      return false;
    }
  }

  /// Login with email and password
  Future<bool> login({required String email, required String password}) async {
    isLoading = true;
    errorMessage = null;

    try {
      await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      currentUser = await _account.get();
      isLoading = false;
      return true;
    } on AppwriteException catch (e) {
      errorMessage = e.message ?? 'Login failed. Please try again.';
      isLoading = false;
      return false;
    } catch (e) {
      errorMessage = 'An unexpected error occurred.';
      isLoading = false;
      return false;
    }
  }

  /// Returns the role stored in the users collection for the current user.
  Future<String?> getUserRole() async {
    try {
      final user = currentUser ?? await _account.get();
      final doc = await _databases.getDocument(
        databaseId: AppwriteService.databaseId,
        collectionId: AppwriteService.usersCol,
        documentId: user.$id,
      );
      return doc.data['role'] as String?;
    } catch (_) {
      return null;
    }
  }

  /// Check if there's an existing session
  Future<bool> getCurrentUser() async {
    try {
      currentUser = await _account.get();
      return true;
    } catch (_) {
      currentUser = null;
      return false;
    }
  }

  /// Logout and delete the current session
  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      currentUser = null;
    } on AppwriteException catch (e) {
      errorMessage = e.message ?? 'Logout failed.';
    }
  }
}
