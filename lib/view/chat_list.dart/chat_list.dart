import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_bar.dart';
// import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
// import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
// import 'package:gofriendsgo/utils/navigations/navigations.dart';
// import 'package:gofriendsgo/view/chat_screen/chat_screen.dart';
import 'package:gofriendsgo/view_model/chats/chat_list_viewmodel.dart';
import 'package:gofriendsgo/widgets/booking_details_widgets/booking_details_searchbar.dart';
import 'package:provider/provider.dart';

import '../../model/chat_models/chat_list_model.dart';
import '../../utils/constants/custom_text.dart';
import '../../utils/constants/paths.dart';
import '../../utils/navigations/navigations.dart';
import '../chat_screen/chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  final bool fromBottomNav;
  const ChatListScreen({super.key, required this.fromBottomNav});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    context.read<ChatListViewmodel>().fetchChatList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ChatData> chatList = [
      ChatData(
      id: 5,
      name: 'Rail Booking',
      tag: 'Gym',
      userId: 105,
      backendId: null,
      status: 3,
      createdAt: DateTime.now().subtract(Duration(minutes: 10)),
      updatedAt: DateTime.now().subtract(Duration(hours: 5)),
    ),
      ChatData(
        id: 6,
        name: 'Hotel Booking',
        tag: 'Gym',
        userId: 105,
        backendId: null,
        status: 3,
        createdAt: DateTime.now().subtract(Duration(minutes: 20)),
        updatedAt: DateTime.now().subtract(Duration(hours: 5)),
      ),
      ChatData(
        id: 7,
        name: 'Rail Booking',
        tag: 'Gym',
        userId: 105,
        backendId: null,
        status: 3,
        createdAt: DateTime.now().subtract(Duration(minutes: 15)),
        updatedAt: DateTime.now().subtract(Duration(hours: 5)),
      ),ChatData(
        id: 8,
        name: 'Hotel Booking',
        tag: 'Gym',
        userId: 105,
        backendId: null,
        status: 3,
        createdAt: DateTime.now().subtract(Duration(minutes: 2)),
        updatedAt: DateTime.now().subtract(Duration(hours: 5)),
      ),ChatData(
        id: 9,
        name: 'Rail Booking',
        tag: 'Gym',
        userId: 105,
        backendId: null,
        status: 3,
        createdAt: DateTime.now().subtract(Duration(minutes:3)),
        updatedAt: DateTime.now().subtract(Duration(hours: 5)),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, mediaqueryheight(0.08, context)),
          child: CommonGradientAppBar(
            heading: 'Chats',
            fromBottomNav: widget.fromBottomNav,
          )),
      body: SingleChildScrollView(
        child: Consumer<ChatListViewmodel>(builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            color: Colors.transparent,
            child: Column(
            children: [
              const CustomSizedBoxHeight(0.03),
              const BookingDetailsSearch(),
              const CustomSizedBoxHeight(0.03),

              // The actual chat list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chatList.length, // Fetch chat list length
                itemBuilder: (context, index) {
                  final chatItem = chatList[index];
                  return GestureDetector(
                    onTap: () {
                      PageNavigations().push(
                        ChatScreen(chatData: chatList[0]), // Pass in the actual chat data
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      padding: const EdgeInsets.all(4.0),


                      child:
                      Column(
                          children: [
                            Row(
                              children: [
                          // Profile Image & Status Indicator
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white70,
                                child: Image.asset(
                                  'assets/images/bus.png', // Your custom bus image
                                  width: 30,  // Adjust the width for scaling
                                  height: 30, // Adjust the height for scaling
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16.0),
                          // Chat Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      chatItem.name, // Chat Name
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${DateTime.now().difference(chatItem.createdAt).inMinutes.toString()} min', // Adjust according to the model timestamp
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Hey! I need train tickets', // Latest message
                                  style: TextStyle(color: Colors.blueGrey),
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),
                            const Divider(
                              color: Colors.grey, // Set the color of the divider
                              thickness: 1,       // Set the thickness of the divider
                            ),
                  ]
                    )
                  )
                  );
                },
              ),
            ],
            ),
          );
        },
        ),
      ),
    );
  }
}
              // SizedBox(
              //   height: mediaqueryheight(0.85, context),
              //   child: ListView.separated(
              //     separatorBuilder: (context, index) {
              //       return const Divider();
              //     },
              //     itemCount: value.chatsModel!.data.length,
              //     itemBuilder: (context, index) {
              //       final chatListModels = value.chatsModel!.data[index];
              //       return ListTile(
              //         onTap: () {
              //           PageNavigations().push(ChatScreen(
              //             chatData: chatListModels,
              //           ));
              //         },
              //         title: CustomText(
              //           weight: FontWeight.w600,
              //           text: chatListModels.name,
              //           color: AppColors.blackColor,
              //           fontFamily: CustomFonts.inter,
              //           size: 0.04,
              //         ),
              //         subtitle: CustomText(
              //           weight: FontWeight.w300,
              //           text: chatListModels.tag,
              //           color: AppColors.blackColor,
              //           fontFamily: CustomFonts.inter,
              //           size: 0.03,
              //         ),
              //         leading: Container(
              //           width: mediaquerywidth(0.12, context),
              //           height: mediaqueryheight(0.06, context),
              //           decoration: const BoxDecoration(
              //             color: AppColors.whiteColor,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //             child: Image.asset(AppImages.busIcon),
              //           ),
              //         ),
              //         trailing: Column(
              //           children: [
              //             const CustomSizedBoxHeight(0.02),
              //             CustomText(
              //               weight: FontWeight.w300,
              //               text: chatListModels.updatedAt.toString(),
              //               color: AppColors.blackColor,
              //               fontFamily: CustomFonts.inter,
              //               size: 0.03,
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // )
          //  ],
        //  );
       // }),
    //  ),
  //  );
 // }
//}
