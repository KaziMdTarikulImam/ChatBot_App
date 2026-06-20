import 'package:flutter/material.dart';

Widget buildBottomNavbar({
  required int activeIndex,
  required Function(int index) onTap,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 18,
          offset: const Offset(0, -6),
        ),
      ],
    ),
    child: SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomNavItem(
            icon: Icons.home_rounded,
            label: "Home",
            active: activeIndex == 0,
            onTap: () => onTap(0),
          ),
          _bottomNavItem(
            icon: Icons.chat_bubble_rounded,
            label: "Chats",
            active: activeIndex == 1,
            onTap: () => onTap(1),
          ),
          _bottomNavItem(
            icon: Icons.history_rounded,
            label: "History",
            active: activeIndex == 2,
            onTap: () => onTap(2),
          ),
          _bottomNavItem(
            icon: Icons.settings_rounded,
            label: "Settings",
            active: activeIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    ),
  );
}

Widget _bottomNavItem({
  required IconData icon,
  required String label,
  required bool active,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: EdgeInsets.symmetric(
        horizontal: active ? 14 : 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: active ? const Color(0xffdcfce7) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: active ? const Color(0xff16a34a) : Colors.grey,
            size: 24,
          ),

          if (active) ...[
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xff16a34a),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}