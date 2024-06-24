import 'package:flutter/material.dart';
import 'package:moniepoint_assessment/core/core.dart';

class SliderButtonIcon extends StatelessWidget {
  const SliderButtonIcon({
    super.key,
    this.width = 50,
    this.height = 50,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: _getIcon(AppColors.brown),
    );
  }

  Widget _getIcon(Color color) {
    return Icon(
      Icons.arrow_forward_ios,
      size: 12,
      color: color,
    );
  }
}
