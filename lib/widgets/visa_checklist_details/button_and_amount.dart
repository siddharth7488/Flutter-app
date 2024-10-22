import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class GetDetailsAndAmount extends StatelessWidget {
  final double? amount;
  const GetDetailsAndAmount({
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomSizedBoxWidth(0.04),
        CustomButton(
      
          function: () {},
          text: TextStrings.getDetailsButtonText,
          fontSize: 0.04,
          buttonTextColor: AppColors.whiteColor,
          borderColor: AppColors.transparentColor,
          
          fontFamily: CustomFonts.roboto,
        ),
        const CustomSizedBoxWidth(0.04),
         Column(
          children: [
            CustomText(
                text: amount==null? "null" :"₹ ${amount.toString()}",
                fontFamily: CustomFonts.roboto,
                size: 0.07,
                weight: FontWeight.w800,
                color: AppColors.fixedDeparturesAmberColor),
            const CustomText(
              text: TextStrings.perPerson,
              fontFamily: CustomFonts.roboto,
              size: 0.035,
              color: Color.fromRGBO(0, 0, 0, 0.7),
              weight: FontWeight.w500,
            )
          ],
        ),
        const SizedBox()
      ],
    );
  }
}
