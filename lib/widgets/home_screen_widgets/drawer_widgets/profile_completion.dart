import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/profile_screen/profile_editing_screen.dart';

class ProfileCompletionStatus extends StatelessWidget {
  const ProfileCompletionStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomText(
            text: TextStrings.profileProgress,
            fontFamily: CustomFonts.poppins,
            size: 0.027,
            color: Color.fromRGBO(20, 20, 20, .6)),
        GestureDetector(
          onTap: () {
                  PageNavigations().push(const ProfileEditingScreen());
          },
          child: const CustomText(
              text: TextStrings.addPhoto,
              fontFamily: CustomFonts.poppins,
              size: 0.027,
              color: Color.fromRGBO(21, 1, 154, 1)),
        )
      ],
    );
  }
}
