import 'package:flutter/material.dart';
import 'package:moniepoint_assessment/core/core.dart';

import 'home_slider_image_widget.dart';

class HomeVerticalSliderContentWidget extends StatefulWidget {
  final List<Key> sliderActionKeys;
  const HomeVerticalSliderContentWidget({super.key, required this.sliderActionKeys});

  @override
  State<HomeVerticalSliderContentWidget> createState() => _HomeVerticalSliderContentWidgetState();
}

class _HomeVerticalSliderContentWidgetState extends State<HomeVerticalSliderContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          HomeSliderImageWidget(
            imageUrl: AppImageAssets.livingRoom1,
            imageAnimationKey: widget.sliderActionKeys[0],
          ),
          UIHelper.verticalSpaceMedium,
          Row(
            children: [
              Expanded(
                child: HomeSliderImageWidget(
                  imageUrl: AppImageAssets.livingRoom3,
                  imageAnimationKey: widget.sliderActionKeys[1],
                ),
              ),
              UIHelper.horizontalSpaceMedium,
              Expanded(
                child: HomeSliderImageWidget(
                  imageUrl: AppImageAssets.livingRoom4,
                  imageAnimationKey: widget.sliderActionKeys[2],
                ),
              ),
            ],
          ),
          UIHelper.verticalSpaceMedium,
          Row(
            children: [
              Expanded(
                child: HomeSliderImageWidget(
                  imageUrl: AppImageAssets.livingRoom3,
                  imageAnimationKey: widget.sliderActionKeys[3],
                ),
              ),
              UIHelper.horizontalSpaceMedium,
              Expanded(
                child: HomeSliderImageWidget(
                  imageUrl: AppImageAssets.livingRoom4,
                  imageAnimationKey: widget.sliderActionKeys[4],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
