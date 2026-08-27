import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import '../services/appwrite_service.dart';

class AuthViewModel {
  final Account _account = AppwriteService().account;

  bool isLoading = false;
  String? errorMessage;
  models.User? currentUser;

  /// Create a new account without auto-login (for registration flow)
  Future<bool> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;

    try {
      // Create the account only (no auto-login)
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

  /// Create a new account and auto-login
  Future<bool> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;

    try {
      // Create the account
      await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      // Auto-login after signup
      await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );

      // Fetch the user
      currentUser = await _account.get();
      isLoading = false;
      return true;
    } on AppwriteException catch (e) {
      errorMessage = e.message ?? 'Signup failed. Please try again.';
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
