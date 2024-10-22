import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/app_textfields.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/signup_screen/signup_screen.dart';
import 'package:gofriendsgo/view_model/user_details.dart';
import 'package:gofriendsgo/widgets/login_widget/login_text.dart';
import 'package:provider/provider.dart';

TextEditingController emailController = TextEditingController();

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserViewModel>(
        builder: (context, userViewModel, child) {
          return Stack(
            children: [
              Padding(
                padding: commonScreenPadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomSizedBoxHeight(0.1),
                          const AppdecorText(
                            text: 'Login',
                            size: 0.08,
                            color: Colors.black,
                            weight: FontWeight.bold,
                          ),
                          const CustomSizedBoxHeight(0.05),
                          const CustomText(
                              fontFamily: CustomFonts.poppins,
                              text: TextStrings.loginMainText,
                              size: 0.04,
                              color: Colors.black),
                          const CustomSizedBoxHeight(0.04),
                          const CustomText(
                              fontFamily: CustomFonts.poppins,
                              text: 'Email Address',
                              size: 0.04,
                              color: Colors.black),
                          Inputfield(
                              submitFun: (value) {
                                if (loginFormKey.currentState!.validate()) {
                                  userViewModel.loginUser(emailController.text);
                                }
                                return null;
                              },
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
                              controller: emailController,
                              hinttext: 'abc@gmail.com',
                              prefixIcon: const Icon(Icons.email_outlined))
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        LoginText(onTapSignUp: () {
                          PageNavigations().push(const SignUpScreen());
                        }),
                        const CustomSizedBoxHeight(0.02),
                        CustomButton(
                            fontFamily: CustomFonts.poppins,
                            function: () {
                              // context.read<ProfileViewModel>().fetchProfile();
                              if (loginFormKey.currentState!.validate()) {
                                userViewModel.loginUser(emailController.text);
                              }
                            },
                            text: 'Get OTP',
                            fontSize: 0.04,
                            buttonTextColor: Colors.white,
                            borderColor: Colors.transparent),
                        const CustomSizedBoxHeight(0.04),
                      ],
                    ),
                  ],
                ),
              ),
              if (userViewModel.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
