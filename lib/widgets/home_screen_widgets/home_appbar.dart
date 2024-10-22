import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/notifications_screen/notifications_screen.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(  // Wrapping in SafeArea to avoid overflow into the status bar
      child: Container(
        height: mediaqueryheight(0.09, context),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: AppColors.gradientColors,
          ),
        ),
        child: Column(
          children: [
            const CustomSizedBoxHeight(0.003),
            const CustomSizedBoxHeight(0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CustomSizedBoxWidth(0.05),
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: const Icon(Icons.menu, color: AppColors.whiteColor, size:24),
                    ),
                    const CustomSizedBoxWidth(0.03),
                    const CustomText(
                      weight: FontWeight.bold,
                      text: "Home",
                      fontFamily: CustomFonts.roboto,
                      size: 0.05,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        PageNavigations().push(const NotificationScreen());
                      },
                      child: SvgPicture.asset(AppImages.notificationsUnread),
                    ),
                    const CustomSizedBoxWidth(0.09),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
