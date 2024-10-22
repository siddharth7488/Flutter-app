
import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';


AppBar appBarProfile() {
    return AppBar(
      backgroundColor: AppColors.transparentColor,
      title: const CustomText(
        text: "Profile",
        fontFamily: CustomFonts.inter,
        size: 0.065,
        color: AppColors.blackColor,
        weight: FontWeight.w600,
      ),
    );
  }