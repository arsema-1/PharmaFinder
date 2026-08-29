import 'package:flutter/material.dart';
import 'user_homescreen.dart';

// Placeholder screens for tabs not yet built
class _BrowseScreen extends StatelessWidget {
  const _BrowseScreen();
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Browse')));
}

class _SavedScreen extends StatelessWidget {
  const _SavedScreen();
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Saved')));
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Profile')));
}

class _SellerScreen extends StatelessWidget {
  const _SellerScreen();
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Seller')));
}

class UserShell extends StatefulWidget {
  const UserShell({super.key});

  @override
  State<UserShell> createState() => _UserShellState();
}

class _UserShellState extends State<UserShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    _BrowseScreen(),
    _SavedScreen(),
    _ProfileScreen(),
    _SellerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        height: 61,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, 'Home', 0),
            _navItem(Icons.grid_view_outlined, 'Browse', 1),
            _navItem(Icons.favorite_border, 'Saved', 2),
            _navItem(Icons.person_outline, 'Profile', 3),
            _navItem(Icons.storefront_outlined, 'Seller', 4),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final selected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 18,
            color: selected ? const Color(0xFF00A875) : const Color(0xFF596360),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 7,
              color:
                  selected ? const Color(0xFF00A875) : const Color(0xFF596360),
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
