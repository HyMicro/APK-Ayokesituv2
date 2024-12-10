import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 372,
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          items: _buildNavItems(),
          currentIndex: selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavItems() {
    final items = [
      {'icon': 'Home.svg', 'label': 'Home'},
      {'icon': 'Heart.svg', 'label': 'Favorites'},
      {'icon': 'Send.svg', 'label': 'Messages'},
      {'icon': 'User.svg', 'label': 'Profile'},
    ];

    return items
        .map((item) => _buildNavItem(
              icon: item['icon']!,
              label: item['label']!,
              index: items.indexOf(item),
            ))
        .toList();
  }

  BottomNavigationBarItem _buildNavItem({
    required String icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? const Color(0xfe00A550)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/img/svg/$icon',
            color: selectedIndex == index ? Colors.black : Colors.grey,
            width: 32,
          ),
        ),
      ),
      label: '',
    );
  }
}
