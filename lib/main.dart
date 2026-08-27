import 'package:flutter/material.dart';
import 'screens/shared/splashscreen.dart';
import 'screens/home/home_screen.dart';
import 'services/appwrite_service.dart';
import 'viewmodels/auth_vm.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppwriteService().init();
  runApp(const PharmaFinderApp());
}

class PharmaFinderApp extends StatelessWidget {
  const PharmaFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PharmaFinder',
      theme: ThemeData(fontFamily: 'Roboto', useMaterial3: true),
      home: const AuthGate(),
    );
  }
}

/// Checks if the user has an existing session.
/// If yes, navigates to HomeScreen. Otherwise, shows SplashScreen.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final _authVm = AuthViewModel();
  bool _checking = true;
  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final hasSession = await _authVm.getCurrentUser();
    if (mounted) {
      setState(() {
        _loggedIn = hasSession;
        _checking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF007A55),
          ),
        ),
      );
    }

    if (_loggedIn) {
      return HomeScreen(
        userName: _authVm.currentUser?.name ?? 'User',
      );
    }

    return const SplashScreen();
  }
}
