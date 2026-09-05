import 'package:appwrite/appwrite.dart';
import '../services/appwrite_service.dart';

class PharmacyViewModel {
  final Databases _databases = AppwriteService().databases;

  String? errorMessage;

  /// Save a new pharmacy document to the `pharmacies` collection.
  Future<bool> savePharmacy({
    required String userId,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    String? phone,
    String? licenseNumber,
  }) async {
    errorMessage = null;
    try {
      await _databases.createDocument(
        databaseId: AppwriteService.databaseId,
        collectionId: AppwriteService.pharmaciesCol,
        documentId: ID.unique(),
        data: {
          'userId': userId,
          'name': name,
          'address': address,
          'latitude': latitude,
          'longitude': longitude,
          'phone': phone ?? '',
          'licenseNumber': licenseNumber ?? '',
          'isVerified': false,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );
      return true;
    } on AppwriteException catch (e) {
      errorMessage = e.message ?? 'Failed to save pharmacy.';
      return false;
    } catch (_) {
      errorMessage = 'An unexpected error occurred.';
      return false;
    }
  }

  /// Fetch all pharmacies (for the user-facing list).
  Future<List<Map<String, dynamic>>> fetchPharmacies() async {
    try {
      final result = await _databases.listDocuments(
        databaseId: AppwriteService.databaseId,
        collectionId: AppwriteService.pharmaciesCol,
      );
      return result.documents.map((d) => d.data).toList();
    } catch (_) {
      return [];
    }
  }
}
