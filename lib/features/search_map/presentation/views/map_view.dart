import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moniepoint_assessment/common/common.dart';
import 'package:moniepoint_assessment/core/core.dart';
import 'package:moniepoint_assessment/core/utils/app_strings.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with SingleTickerProviderStateMixin {
  final TextEditingController searchTextController = TextEditingController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _widthAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _widthAnimation = Tween<double>(begin: 0, end: 260).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    setState(() {
      _isExpanded = true;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context),
      width: screenWidth(context),
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(AppImageAssets.mapImage), fit: BoxFit.cover),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SlideTransition(
              position: _slideAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _widthAnimation,
                    builder: (context, child) {
                      return SizedBox(
                        height: 48,
                        width: _isExpanded ? _widthAnimation.value : 0,
                        child: AppSearchField(
                          controller: searchTextController,
                          onSearchPressed: () {},
                        ),
                      );
                    },
                  ),
                  UIHelper.horizontalSpaceMedium,
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: _isExpanded ? 50 : 0,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: _isExpanded
                        ? const Center(
                            child: Icon(
                              Icons.history_rounded,
                              color: AppColors.black,
                              size: 20,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 100),
              child: SlideTransition(
                position: _slideAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        _buildIconButton(
                          icon: Icons.collections_bookmark_outlined,
                          onPressed: () {},
                        ),
                        UIHelper.verticalSpaceSmall,
                        _buildIconButton(
                          icon: Icons.navigation_outlined,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.collections_bookmark_outlined,
                            color: AppColors.white,
                            size: 20,
                          ),
                          UIHelper.horizontalSpaceMedium,
                          Text(
                            AppStrings.listOfVariants,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required VoidCallback onPressed}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: _isExpanded ? 50 : 0,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onPressed,
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
