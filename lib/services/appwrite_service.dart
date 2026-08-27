import 'package:appwrite/appwrite.dart';

class AppwriteService {
  static final AppwriteService _instance = AppwriteService._internal();
  factory AppwriteService() => _instance;
  AppwriteService._internal();

  late final Client client;
  late final Account account;

  bool _initialized = false;

  void init() {
    if (_initialized) return;
    client =
        Client()
          ..setEndpoint('https://fra.cloud.appwrite.io/v1')
          ..setProject('6a90500a0036647d6565')
          ..setSelfSigned(status: true);
    account = Account(client);
    _initialized = true;
  }
}
