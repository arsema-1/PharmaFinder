import 'package:flutter/material.dart';
import 'user_homescreen.dart';
import 'user_browse.dart';
import 'user_profile.dart';
import 'user_saved_screen.dart';


// ============================================================
// USER SHELL
// ============================================================

class UserShell extends StatefulWidget {
  const UserShell({super.key});

  @override
  State<UserShell> createState() => _UserShellState();
}

class _UserShellState extends State<UserShell> {
  int _currentIndex = 0;

  // ============================================================
  // SCREENS
  // ============================================================

  final List<Widget> _screens = const [
    HomeScreen(),
    BrowseScreen(),
    SavedScreen(),
    ProfileScreen(),

  ];

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      // ========================================================
      // BOTTOM NAVIGATION
      // ========================================================

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 65,

          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _navItem(
                Icons.home,
                'Home',
                0,
              ),

              _navItem(
                Icons.grid_view_outlined,
                'Browse',
                1,
              ),

              _navItem(
                Icons.favorite_border,
                'Saved',
                2,
              ),

              _navItem(
                Icons.person_outline,
                'Profile',
                3,
              ),


            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // NAVIGATION ITEM
  // ============================================================

  Widget _navItem(
      IconData icon,
      String label,
      int index,
      ) {
    final bool selected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 18,
            color: selected
                ? const Color(0xFF00A875)
                : const Color(0xFF596360),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            style: TextStyle(
              fontSize: 7,
              color: selected
                  ? const Color(0xFF00A875)
                  : const Color(0xFF596360),
              fontWeight: selected
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}