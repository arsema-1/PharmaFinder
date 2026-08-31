import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color primaryGreen = Color(0xFF006C49);
  static const Color lightGreen = Color(0xFFE8F3F0);
  static const Color background = Color(0xFFF9F9FF);
  static const Color textColor = Color(0xFF343847);
  static const Color secondaryText = Color(0xFF68706D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // =====================================================
      // TOP APP BAR
      // =====================================================

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
          padding: const EdgeInsets.fromLTRB(
            10,
            8,
            10,
            30,
          ),
          child: Column(
            children: [

              // =================================================
              // PROFILE CARD
              // =================================================

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(10),
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
                    Container(
                      height: 95,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5F2EF),
                        borderRadius:
                        BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [

                          // Profile picture
                          Positioned(
                            bottom: -2,
                            child: Container(
                              width: 72,
                              height: 72,
                              decoration:
                              const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding:
                              const EdgeInsets.all(3),
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  color:
                                  const Color(
                                    0xFFF7F9F8,
                                  ),
                                  shape:
                                  BoxShape.circle,
                                  border:
                                  Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Edit button
                          Positioned(
                            bottom: -2,
                            right:
                            MediaQuery.of(context)
                                .size
                                .width /
                                2 -
                                50,
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration:
                              const BoxDecoration(
                                color: primaryGreen,
                                shape:
                                BoxShape.circle,
                              ),
                              child: IconButton(
                                padding:
                                EdgeInsets.zero,
                                onPressed: () {
                                  // Edit profile
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

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
                      style: TextStyle(
                        fontSize: 13,
                        color: secondaryText,
                      ),
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
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 18,
                  ),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xFFFFD8D5),
                    foregroundColor:
                    const Color(0xFFBA1A1A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),

      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================


    );
  }

  // =========================================================
  // MENU ITEM
  // =========================================================

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
          constraints: const BoxConstraints(
            minHeight: 42,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
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
                child: Icon(
                  icon,
                  color: primaryGreen,
                  size: 19,
                ),
              ),

              const SizedBox(width: 11),

              // Title / subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.center,
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
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Log Out',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to log out?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: primaryGreen,
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);

                // Add your logout logic here.
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: Color(0xFFBA1A1A),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


}