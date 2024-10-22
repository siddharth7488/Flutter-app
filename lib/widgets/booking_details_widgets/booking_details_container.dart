import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/bookings_model/bookings_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/gradient_icons.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:intl/intl.dart';

class BookingDetailsContainer extends StatelessWidget {
  final List<BookingModel> value;
  const BookingDetailsContainer(
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      height: mediaqueryheight(0.7, context),
      width: mediaquerywidth(0.94, context),
      child: ListView.builder(
        itemCount: value.length,
        itemBuilder: (context, index) {
          final bookingList = value[index];
          if (value.isEmpty) {
            return const Center(
              child: CustomText(
                  text: 'No Data Fount',
                  fontFamily: CustomFonts.lato,
                  size: 0.05,
                  color: AppColors.blackColor),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.whiteColor,
                ),
                width: mediaquerywidth(0.33, context),
                height: mediaqueryheight(0.15, context),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: mediaquerywidth(0.03, context),
                        right: mediaquerywidth(0.03, context),
                        top: mediaquerywidth(0.02, context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              weight: FontWeight.w800,
                              text: bookingList.sector,
                              fontFamily: CustomFonts.roboto,
                              size: 0.04,
                              color: AppColors.blackColor),
                          CustomText(
                              weight: FontWeight.w800,
                              text: bookingList.amount,
                              fontFamily: CustomFonts.roboto,
                              size: 0.04,
                              color: AppColors.blackColor),
                        ],
                      ),
                    ),
                    const CustomSizedBoxHeight(0.01),
                    Padding(
                      padding: EdgeInsets.only(
                        left: mediaquerywidth(0.03, context),
                        right: mediaquerywidth(0.03, context),
                        top: mediaquerywidth(0.02, context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              text: bookingList.userName,
                              fontFamily: CustomFonts.roboto,
                              size: 0.037,
                              color: AppColors.blackColor),
                          CustomText(
                              text: _formatDateString(
                                  bookingList.createdAt.toString()),
                              fontFamily: CustomFonts.roboto,
                              size: 0.037,
                              color: AppColors.blackColor),
                        ],
                      ),
                    ),
                    const Divider(endIndent: 20, indent: 20),
                    Padding(
                      padding: EdgeInsets.only(
                        left: mediaquerywidth(0.03, context),
                        right: mediaquerywidth(0.03, context),
                        bottom: mediaquerywidth(0.01, context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              weight: FontWeight.w600,
                              text: bookingList.services,
                              fontFamily: CustomFonts.roboto,
                              size: 0.04,
                              color: AppColors.blackColor),
                          GradientIcon(
                              Icons.file_download_outlined,
                              mediaquerywidth(0.07, context),
                              const LinearGradient(
                                  colors: AppColors.gradientColors)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  String _formatDateString(String dateTimeString) {
    // Parse the input string to a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the DateTime object to the desired string format
    String formattedDate = DateFormat('dd-MMM-yyyy').format(dateTime);

    return formattedDate;
  }
}
