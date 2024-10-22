import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/visa_model/visa_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/widgets/visa_checklist_details/appbar.dart';
import 'package:gofriendsgo/widgets/visa_checklist_details/button_and_amount.dart';
import 'package:gofriendsgo/widgets/visa_checklist_details/heading_and_subheading.dart';
import 'package:gofriendsgo/widgets/visa_checklist_details/package_details.dart';

class VisaChecklistDetailsScreen extends StatelessWidget {
  final Visa visa;
  const VisaChecklistDetailsScreen({required this.visa, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, mediaqueryheight(0.09, context)),
        child: const VisaCheckListAppbar(),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: mediaqueryheight(0.03, context),
            left: mediaquerywidth(0.05, context),
            right: mediaquerywidth(0.05, context)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 4,
                        color: AppColors.blackColor),
                  ],
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(mediaqueryheight(0.02, context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomSizedBoxHeight(0.02),
                      const VisaRequirementHeading(),
                      const CustomSizedBoxHeight(0.015),
                      const Divider(),
                      const CustomSizedBoxHeight(0.025),
                      VisaChecklistSubHeading(
                        countryName: visa.visaFor,
                      ),
                      const Divider(),
                      const CustomSizedBoxHeight(0.03),
                       HeadingAndDetails(visa.details.first),
                    ],
                  ),
                ),
              ),
              const CustomSizedBoxHeight(0.04),
              GetDetailsAndAmount(
                amount: visa.details[0].price,
              ),
              const CustomSizedBoxHeight(0.04),
            ],
          ),
        ),
      ),
    );
  }
}
