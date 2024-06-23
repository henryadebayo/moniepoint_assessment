import 'package:flutter/material.dart';
import 'package:moniepoint_assessment/core/core.dart';

class BottomNavigationBarIcon extends StatelessWidget {
  const BottomNavigationBarIcon({
    super.key,
    required this.onTap,
    required this.icon,
    required this.isSelected,
  });
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Container(
        height: isSelected ? 50 : 40,
        width: isSelected ? 50 : 40,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.black,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppColors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
