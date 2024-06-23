import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint_assessment/core/core.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    required this.controller,
    required this.onSearchPressed,
    super.key,
    this.onFilterPressed,
    this.isSearching = false,
  });
  final TextEditingController controller;
  final VoidCallback? onFilterPressed;
  final VoidCallback onSearchPressed;
  final bool isSearching;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0.w),
      child: TextField(
        controller: controller,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 8.0.w),
          prefixIcon: IconButton(
            focusColor: AppColors.primaryColor,
            onPressed: onSearchPressed,
            icon: const Icon(
              Icons.search,
              color: AppColors.black,
            ),
          ),
          suffixIcon: IconButton(
            focusColor: AppColors.primaryColor,
            onPressed: onFilterPressed,
            icon: isSearching
                ? const Icon(
                    Icons.cancel,
                    color: AppColors.primaryColor,
                  )
                : const SizedBox(),
          ),
          focusColor: AppColors.primaryColor,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide(color: AppColors.white),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide(color: AppColors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          fillColor: AppColors.white,
          filled: true,
          hintText: 'Saint Petersburg',
          hintStyle: TextStyle(
            // fontFamily: "BrfRegular",
            fontSize: 14.0.sp,
            color: AppColors.grey.withOpacity(0.5),
          ),
        ),
        onSubmitted: (_) {
          FocusScope.of(context).unfocus(); // Close the keyboard
          onSearchPressed(); // Fire the search function
        },
      ),
    );
  }
}
