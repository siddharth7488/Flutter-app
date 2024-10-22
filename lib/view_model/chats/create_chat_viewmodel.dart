import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/chat_models/create_chat_model.dart';
import 'package:gofriendsgo/services/chats/create_chat_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:http/http.dart';

class CreateChatViewModel extends ChangeNotifier {
  final CreateChatService _createChatService = CreateChatService();
 final List<String> _messages=[];
  List<String> get messages => _messages;

  createANewChat(CreateChatRequest createChatRequest) async {
    final Response? response = await _createChatService.createChat(
        createChatRequest, SharedPreferecesServices.token!);
    if (response != null && response.statusCode == 200) {
      log("message sended successfully");
      log(response.body);
      
    } else {
      log("some thing went wrong with creating chat");
    }
  }


}
