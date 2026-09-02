import 'package:flutter/material.dart';
import '../../viewmodels/auth_vm.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color primaryGreen = Color(0xFF006C49);
  static const Color lightGreen = Color(0xFFE8F3F0);
  static const Color background = Color(0xFFF9F9FF);
  static const Color textColor = Color(0xFF343847);
  static const Color secondaryText = Color(0xFF68706D);

  final _authVm = AuthViewModel();
  bool _loggingOut = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,


      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        automaticallyImplyLeading: false,

        title: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 21,
              color: Color(0xFF68706D),
            ),

            const Spacer(),

            const Text(
              'PharmaFinder',
              style: TextStyle(
                color: primaryGreen,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            const Icon(
              Icons.shopping_cart_outlined,
              size: 21,
              color: Color(0xFF68706D),
            ),
          ],
        ),
      ),

      // =====================================================
      // BODY
      // =====================================================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 30),
          child: Column(
            children: [
              // =================================================
              // PROFILE CARD
              // =================================================
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Profile cover


                    const SizedBox(height: 9),

                    const Text(
                      'BETTY B',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF252936),
                      ),
                    ),

                    const SizedBox(height: 3),

                    const Text(
                      'betty.b@example.com',
                      style: TextStyle(fontSize: 13, color: secondaryText),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),

              const SizedBox(height: 56),

              // =================================================
              // MENU ITEMS
              // =================================================
              _menuItem(
                icon: Icons.favorite_border,
                title: 'My Saved Items',
                onTap: () {
                  // Navigate to saved items
                },
              ),

              const SizedBox(height: 6),

              _menuItem(
                icon: Icons.location_on_outlined,
                title: 'Location',
                subtitle: 'Bole, Addis Ababa',
                onTap: () {
                  // Location
                },
              ),

              const SizedBox(height: 6),

              _menuItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {
                  // Settings
                },
              ),

              const SizedBox(height: 6),

              _menuItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  // Help & Support
                },
              ),

              // =================================================
              // LOGOUT
              // =================================================
              const SizedBox(height: 82),

              SizedBox(
                width: double.infinity,
                height: 43,
                child: ElevatedButton.icon(
                  onPressed:
                      _loggingOut ? null : () => _showLogoutDialog(context),
                  icon:
                      _loggingOut
                          ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFFBA1A1A),
                            ),
                          )
                          : const Icon(Icons.logout, size: 18),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD8D5),
                    foregroundColor: const Color(0xFFBA1A1A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 42),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon circle
              Container(
                width: 31,
                height: 31,
                decoration: const BoxDecoration(
                  color: lightGreen,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: primaryGreen, size: 19),
              ),

              const SizedBox(width: 11),

              // Title / subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),

                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 10,
                          color: secondaryText,
                        ),
                      ),
                  ],
                ),
              ),

              // Arrow
              const Icon(
                Icons.chevron_right,
                size: 21,
                color: Color(0xFF53605B),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // LOGOUT DIALOG
  // =========================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            style: TextStyle(fontWeight: FontWeight.bold),
            'Log Out',

          ),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(
                'Cancel',
                style: TextStyle(color: primaryGreen),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(ctx); // close dialog
                setState(() => _loggingOut = true);

                await _authVm.logout();

                if (!mounted) return;
                setState(() => _loggingOut = false);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text(
                'Log Out',
                style: TextStyle(color: Color(0xFFBA1A1A)),
              ),
            ),
          ],
        );
      },
    );
  }
}
