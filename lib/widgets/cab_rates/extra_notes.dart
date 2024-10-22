import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/cab_rates_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';


class ExtraNoteInCabRates extends StatelessWidget {
  const ExtraNoteInCabRates({
    super.key,
    required this.serviceDetails,
  });

  final CabRatesModel serviceDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: AppColors.backgroundColor),
      child: CustomText(
          text: serviceDetails.extraNote,
          fontFamily: CustomFonts.roboto,
          size: 0.028,
          color: const Color.fromRGBO(0, 0, 0, 0.8)),
    );
  }
}