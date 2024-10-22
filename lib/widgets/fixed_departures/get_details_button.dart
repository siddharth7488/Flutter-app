import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class GetDetailsButton extends StatelessWidget {
  const GetDetailsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      // fontWeight: FontWeight.w500,
      function: () {},
      text: TextStrings.getDetailsButtonText,
      fontSize: 0.04,
      buttonTextColor: AppColors.whiteColor,
      borderColor: AppColors.transparentColor,
      fontFamily: CustomFonts.roboto,
    );
  }
}
