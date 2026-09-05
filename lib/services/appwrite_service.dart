import 'package:appwrite/appwrite.dart';

class AppwriteService {
  static final AppwriteService _instance = AppwriteService._internal();
  factory AppwriteService() => _instance;
  AppwriteService._internal();

  late final Client client;
  late final Account account;
  late final Databases databases;

  bool _initialized = false;

  // ── Replace these with your actual Appwrite values ──────────────────────
  static const String databaseId = '6a9926ef001f3a2797df';
  static const String usersCol = 'users';
  static const String pharmaciesCol = 'pharmacies';
  // ────────────────────────────────────────────────────────────────────────

  void init() {
    if (_initialized) return;
    client =
        Client()
          ..setEndpoint('https://fra.cloud.appwrite.io/v1')
          ..setProject('6a90500a0036647d6565')
          ..setSelfSigned(status: true);
    account = Account(client);
    databases = Databases(client);
    _initialized = true;
  }
}
