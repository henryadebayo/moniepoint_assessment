import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bottom_navigation_bar_icon_widget.dart';

class AppBottomNavigationWidget extends StatefulWidget {
  const AppBottomNavigationWidget({super.key, required this.items});

  final List<BottomNavigationItem> items;

  @override
  State<AppBottomNavigationWidget> createState() => _AppBottomNavigationWidgetState();
}

class _AppBottomNavigationWidgetState extends State<AppBottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 43.w, right: 43.w, bottom: 16.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              widget.items.length,
              (index) => BottomNavigationBarIcon(
                icon: widget.items[index].icon,
                isSelected: widget.items[index].isSelected,
                onTap: widget.items[index].onTap,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavigationItem {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  const BottomNavigationItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
}
