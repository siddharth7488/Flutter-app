// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/chat_models/create_chat_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view_model/chats/create_chat_viewmodel.dart';
import 'package:gofriendsgo/widgets/chat_widgets/chat_field.dart';
import 'package:provider/provider.dart';

class CreateChatScreen extends StatefulWidget {
  final String serviceName;
  final String image;
  const CreateChatScreen(
      {super.key, required this.serviceName, required this.image});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<CreateChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    context
        .read<CreateChatViewModel>()
        .createANewChat(CreateChatRequest(name: widget.serviceName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size(double.infinity, mediaqueryheight(0.09, context)),
            child: Container(
              height: mediaqueryheight(0.21, context),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: AppColors.gradientColors,
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft)),
              child: Column(
                children: [
                  SizedBox(
                    height: mediaqueryheight(0.05, context),
                  ),
                  Row(
                    children: [
                      const CustomSizedBoxWidth(0.04),
                      GestureDetector(
                        onTap: () {
                          PageNavigations().pop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.whiteColor,
                          size: mediaquerywidth(0.07, context),
                        ),
                      ),
                      const CustomSizedBoxWidth(0.02),
                      Container(
                        height: mediaqueryheight(0.055, context),
                        width: mediaqueryheight(0.055, context),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    API.baseImageUrl + widget.image))),
                      ),
                      const CustomSizedBoxWidth(0.03),
                      CustomText(
                          weight: FontWeight.w600,
                          text: widget.serviceName,
                          fontFamily: CustomFonts.inter,
                          size: 0.045,
                          color: Colors.white)
                    ],
                  ),
                ],
              ),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(child: SizedBox()),
            _buildMessageInput(),
          ],
        ));
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: ChatField(
            controller: _messageController,
            hinttext: 'Type your message',
          )),
          const CustomSizedBoxWidth(0.02),
          Container(
            width: mediaquerywidth(0.13, context),
            height: mediaqueryheight(0.06, context),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: AppColors.gradientColors)),
            child: IconButton(
              icon: const Icon(
                Icons.send,
                color: AppColors.whiteColor,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
