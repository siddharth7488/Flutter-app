import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofriendsgo/model/user_model/user_details_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/app_textfields.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/login_screen/login_screen.dart';
import 'package:gofriendsgo/view/otp_verify_screen/otp_screen.dart';
import 'package:gofriendsgo/view_model/user_details.dart';
import 'package:gofriendsgo/widgets/signup_widget/custom_field.dart';
import 'package:gofriendsgo/widgets/signup_widget/drop_down.dart';
import 'package:gofriendsgo/widgets/signup_widget/sign_text.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _refferelController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: true);
    return Scaffold(
      body: Padding(
        padding: commonScreenPadding(context),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Form(
                key: _signUpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomSizedBoxHeight(0.1),
                    const AppdecorText(
                      text: 'Sign Up',
                      size: 0.08,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                    const CustomSizedBoxHeight(0.05),
                    LabeledInputField(
                      keyboardType: TextInputType.name,
                      textInputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
                      ],
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "please enter your name";
                        } else {
                          return null;
                        }
                      },
                      controller: _nameController,
                      hintText: 'Enter your Name',
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.account_circle_outlined),
                    ),
                    const CustomSizedBoxHeight(0.02),
                    LabeledInputField(
                      submitFun: (value) {
                        if (_signUpFormKey.currentState!.validate()) {
                          _sourceController.text =
                              userViewModel.sourceController;
                          UserDetails userDetails = UserDetails(
                            name: _nameController.text,
                            email: _emailController.text,
                            role: 'user',
                            referral: _refferelController.text.isEmpty
                                ? null
                                : _refferelController.text,
                            source: _sourceController.text,
                          );
                          PageNavigations().push(OtpVerifyScreen(
                            signUpEmail: _emailController.text,
                            signUpName: _nameController.text,
                            userDetails: userDetails,
                          ));
                        } else {
                          return;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      hintText: 'Enter your Email Address',
                      labelText: 'Email Address',
                      prefixIcon: const Icon(Icons.email_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }

                        final emailRegExp = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBoxHeight(0.02),
                    LabeledInputField(
                      maxlngths: 1,
                      controller: _refferelController,
                      hintText: '12FDFVD',
                      labelText: 'Referral Code',
                      prefixIcon: const Icon(Icons.tag),
                    ),
                    const CustomSizedBoxHeight(0.02),
                    StaticDropdownField(),
                    const CustomSizedBoxHeight(0.02),
                    Consumer<UserViewModel>(
                      builder: (context, value, child) {
                        if (value.sourceController == 'Other') {
                          return Inputfield(
                            controller: _reasonController,
                            maxLengths: 5,
                            hinttext: 'from where you heard about us',
                          );
                        } else {
                          const SizedBox();
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
              ),
              const CustomSizedBoxHeight(0.03),
              Column(
                children: [
                  const CustomSizedBoxHeight(0.11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignUpText(
                        onTapLogin: () {
                          PageNavigations().push(LoginScreen());
                        },
                      ),
                    ],
                  ),
                  const CustomSizedBoxHeight(0.03),
                  CustomButton(
                      function: () async {
                        if (_signUpFormKey.currentState!.validate()) {
                          _sourceController.text =
                              userViewModel.sourceController;

                          UserDetails userDetails = UserDetails(
                            name: _nameController.text,
                            email: _emailController.text,
                            role: 'user',
                            referral: _refferelController.text.isEmpty
                                ? null
                                : _refferelController.text,
                            source: _sourceController.text,
                          );
                          await userViewModel.registerUser(userDetails);
                          PageNavigations().push(OtpVerifyScreen(
                            signUpEmail: _emailController.text,
                            signUpName: _nameController.text,
                            userDetails: userDetails,
                          ));
                        } else {
                          return;
                        }
                      },
                      text: 'Get OTP',
                      fontSize: 0.04,
                      buttonTextColor: AppColors.whiteColor,
                      borderColor: AppColors.transparentColor,
                      fontFamily: CustomFonts.poppins),
                  const CustomSizedBoxHeight(0.03),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
