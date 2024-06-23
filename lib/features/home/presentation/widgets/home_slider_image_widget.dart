import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moniepoint_assessment/core/utils/app_strings.dart';
import 'package:moniepoint_assessment/features/features.dart';

class HomeSliderImageWidget extends StatefulWidget {
  final String imageUrl;
  final Key imageAnimationKey;
  const HomeSliderImageWidget({super.key, required this.imageUrl, required this.imageAnimationKey});

  @override
  State<HomeSliderImageWidget> createState() => _HomeSliderImageWidgetState();
}

class _HomeSliderImageWidgetState extends State<HomeSliderImageWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.asset(widget.imageUrl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SlideAction(
              key: widget.imageAnimationKey,
              onSubmit: () {},
              elevation: 0,
              borderRadius: 30,
              innerColor: Colors.transparent,
              outerColor: Colors.white,
              height: 58,
              animationDuration: const Duration(seconds: 3),
              sliderButtonIcon: const SliderButtonIcon(),
              submittedIcon: const SizedBox.shrink(),
              sliderRotate: false,
              child: Text(
                AppStrings.address,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
