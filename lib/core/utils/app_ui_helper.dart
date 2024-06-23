import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Contains useful consts to reduce boilerplate and duplicate code
class UIHelper {
  static const double _verticalSpaceTiny = 4;
  static const double _verticalSpaceSmall = 8;
  static const double _verticalSpaceMedium = 16;
  static const double _verticalSpace24 = 24;
  static const double _verticalSpaceLarge = 32;

  static const double _horizontalSpaceTiny = 4;
  static const double _horizontalSpaceSmall = 8;
  static const double _horizontalSpaceMedium = 16;
  static const double _horizontalSpace24 = 24;
  static const double _horizontalSpaceLarge = 32;

  static Widget verticalSpaceTiny = SizedBox(
    height: _verticalSpaceTiny.h,
  );
  static Widget verticalSpaceSmall = SizedBox(
    height: _verticalSpaceSmall.h,
  );
  static Widget verticalSpaceMedium = SizedBox(height: _verticalSpaceMedium.h);
  static Widget verticalSpaceLarge = SizedBox(height: _verticalSpaceLarge.h);
  static Widget verticalSpace24 = SizedBox(height: _verticalSpace24.h);
  static Widget horizontalSpaceTiny = SizedBox(width: _horizontalSpaceTiny.w);
  static Widget horizontalSpaceSmall = SizedBox(width: _horizontalSpaceSmall.w);
  static Widget horizontalSpaceMedium = SizedBox(width: _horizontalSpaceMedium.w);
  static Widget horizontalSpace24 = SizedBox(width: _horizontalSpace24.w);
  static Widget horizontalSpaceLarge = SizedBox(width: _horizontalSpaceLarge.w);
  static Widget customVerticalSpace(double value) => SizedBox(height: value.h);
  static Widget customHorizontalSpace(double value) => SizedBox(width: value.w);
  static Widget zeroSpace = const SizedBox();
}

EdgeInsets defaultPadding = EdgeInsets.symmetric(horizontal: 16.w);
EdgeInsets landscapeDefaultPadding = const EdgeInsets.symmetric(horizontal: 16);
// Screen Size helpers
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) => screenHeight(context) * percentage;
double screenWidthPercentage(BuildContext context, {double percentage = 1}) => screenWidth(context) * percentage;
