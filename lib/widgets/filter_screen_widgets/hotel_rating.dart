import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/view_model/filter_passports_viewmodel.dart';
import 'package:provider/provider.dart';

class HotelRatingContainer extends StatelessWidget {
  const HotelRatingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      color: AppColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          return GestureDetector(
            onTap: () {
              context.read<FilterScreenViewModel>().settingHotelRating(index+1);
              
            },
            child: Column(
              children: [
                const Icon(
                  Icons.star,
                  color: AppColors.fixedDeparturesAmberColor,
                ),
                Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.watch<FilterScreenViewModel>().selectedHotelRating == '${index + 1}'
                        ? Colors.blue
                        : AppColors.blackColor,
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}