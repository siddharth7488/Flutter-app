import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/view_model/user_details.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/sizedbox.dart';

// ignore: must_be_immutable
class StaticDropdownField extends StatelessWidget {
  StaticDropdownField({super.key});

  String? selectedOption;

  final List<String> options = [
    'Sales Person',
    'Social Media',
    'Seminar',
    'Friend',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            CustomText(
              color: AppColors.blackColor,
              fontFamily: CustomFonts.poppins,
              size: 0.04,
              text: 'Where Did You Hear About Us',
            ),
          ],
        ),
        const CustomSizedBoxHeight(0.01),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            prefixIcon: Container(
    // Wrap the Row in a container to set the height
    height: 0, // Adjust this value as needed
    child: Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      const Icon(Icons.waving_hand_outlined), // Safe to use ! since we checked for null
    const VerticalDivider(
    color: Colors.grey, // Set your preferred color here
    thickness: 1, // Divider thickness
    width: 9,  // Spacing between icon and divider
    ),
    ],
    ),
    ),
            hintText: 'Choose an option',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          value: selectedOption,
          onChanged: (String? newValue) {
            Provider.of<UserViewModel>(context, listen: false)
                .sourceController = newValue!;
          },
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
