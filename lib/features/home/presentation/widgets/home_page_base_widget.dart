import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moniepoint_assessment/core/core.dart';
import 'package:moniepoint_assessment/core/utils/app_strings.dart';

class HomeBaseWidget extends StatefulWidget {
  const HomeBaseWidget({super.key});

  @override
  State<HomeBaseWidget> createState() => _HomeBaseWidgetState();
}

class _HomeBaseWidgetState extends State<HomeBaseWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideLeftAnimation;
  late Animation<Offset> _slideUpAnimation;
  late Animation<double> _fadeInFadeOutAnimation;
  FlexibleSpaceBarSettings? _flexibleSpaceBarSettings;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideLeftAnimation = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(_animationController);
    _slideUpAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(_animationController);
    _fadeInFadeOutAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      stretch: true,
      pinned: true,
      scrolledUnderElevation: 1,
      expandedHeight: 500,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final newFlexibleSpaceBarSettings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
          if (newFlexibleSpaceBarSettings != null &&
              newFlexibleSpaceBarSettings.currentExtent != _flexibleSpaceBarSettings?.currentExtent) {
            _flexibleSpaceBarSettings = newFlexibleSpaceBarSettings;
            WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                UIHelper.verticalSpace24,
                _buildGreetingText('Hi, Marina', _slideUpAnimation, 18),
                UIHelper.verticalSpaceLarge,
                _buildGreetingText(AppStrings.letsSelectYour, _slideUpAnimation, 27),
                UIHelper.verticalSpaceLarge,
                _buildOffersRow(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SlideTransition(
          position: _slideLeftAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.brown,
                ),
                UIHelper.horizontalSpaceSmall,
                Text(
                  'Saint Petersburg',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.brown,
                  ),
                ),
              ],
            ),
          ),
        ),
        const CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.person, size: 40),
        ),
      ],
    );
  }

  Widget _buildGreetingText(String text, Animation<Offset> animation, double fontSize) {
    return SlideTransition(
      position: animation,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          color: AppColors.brown,
          fontSize: fontSize,
        ),
      ),
    );
  }

  Widget _buildOffersRow() {
    return FadeTransition(
      opacity: _fadeInFadeOutAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildOfferContainer(
            color: AppColors.primaryColor,
            textColor: AppColors.white,
            startText: AppStrings.buy,
            midText: 1034,
            endText: AppStrings.offers,
            isCircular: true,
          ),
          UIHelper.horizontalSpaceMedium,
          _buildOfferContainer(
            color: AppColors.backgroundWhite,
            textColor: AppColors.brown,
            startText: AppStrings.rent,
            midText: 2212,
            endText: AppStrings.offers,
            isCircular: false,
          ),
        ],
      ),
    );
  }

  Widget _buildOfferContainer({
    required Color color,
    required Color textColor,
    required String startText,
    required double midText,
    required String endText,
    required bool isCircular,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircular ? null : BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              UIHelper.verticalSpaceMedium,
              Text(
                startText,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: textColor,
                ),
              ),
              UIHelper.verticalSpaceLarge,
              Countup(
                begin: 0,
                end: midText,
                duration: const Duration(seconds: 2),
                separator: ',',
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                endText,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: textColor,
                ),
              ),
              UIHelper.verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }
}
