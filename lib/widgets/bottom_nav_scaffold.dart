import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BottomNavScaffold extends StatefulWidget {
  final List<Widget> screens;

  const BottomNavScaffold({super.key, required this.screens});

  @override
  State<BottomNavScaffold> createState() => _BottomNavScaffoldState();
}

class _BottomNavScaffoldState extends State<BottomNavScaffold> {
  int _currentIndex = 0;

  List<BottomNavigationBarItem> get _navItems => [
    BottomNavigationBarItem(
      icon: const Icon(Iconsax.home),
      activeIcon: const Icon(Iconsax.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: const Icon(Iconsax.game),
      activeIcon: const Icon(Iconsax.game),
      label: 'Battle',
    ),
    BottomNavigationBarItem(
      icon: const Icon(Iconsax.award),
      activeIcon: const Icon(Iconsax.award),
      label: 'Tournaments',
    ),
    BottomNavigationBarItem(
      icon: const Icon(Iconsax.profile_circle),
      activeIcon: const Icon(Iconsax.profile_circle),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: const Icon(Iconsax.shopping_bag),
      activeIcon: const Icon(Iconsax.shopping_bag),
      label: 'Shop',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: widget.screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: _navItems,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
