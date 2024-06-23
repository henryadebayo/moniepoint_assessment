import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint_assessment/core/core.dart';
import 'package:moniepoint_assessment/features/features.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideUpAnimation;

  final List<GlobalKey> _slideActionKeys = List.generate(5, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideUpAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(_animationController);

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context),
      width: screenWidth(context),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.homeBackgroundLinearColor,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              const HomeBaseWidget(),
              SliverToBoxAdapter(
                child: SlideTransition(
                  position: _slideUpAnimation,
                  child: HomeVerticalSliderContentWidget(
                    sliderActionKeys: _slideActionKeys,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
