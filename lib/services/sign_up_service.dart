import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/bottom_navigation_bar/bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:gofriendsgo/model/user_model/user_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//from here the user informations are sending to the backend
class UserService {
  Future<Map<String, dynamic>?> registerUser(UserDetails userDetails) async {
    final url = Uri.parse('${API.loginUrl}register');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode(userDetails.toJson());

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        log('Failed to register user: ${response.statusCode}');
        log('Error: ${response.body}');
        return null;
      }
    } catch (error) {
      log('Error registering user: $error');
      return null;
    }
  }

  Future<http.Response> postEmail(String email) async {
    final url = Uri.parse('${API.loginUrl}login');
    final payload = jsonEncode({'email': email});
    try {
      // Send the POST request
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      // Check the response status
      if (response.statusCode == 200) {
        log('Email sent successfully');
        final responseData = jsonDecode(response.body);
        log('Response data: $responseData');
      } else {
        final responseData = jsonDecode(response.body);
        Get.snackbar("validation error", responseData['error']);
        log('Failed to send email: ${response.statusCode}');
        log('Response body: ${response.body}');
      }
      return response;
    } catch (e) {
      log('Error occurred: $e');
      Get.snackbar("validation error", e.toString());
      rethrow;
    }
  }

  Future<http.Response> verifyOtp(int otp, String email) async {
    log("otp $otp");
    log(email);
    final url = '${API.loginUrl}verify/otp/$otp';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'otp': otp,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      log('OTP sent successfully');
      final responseData = jsonDecode(response.body);
      log('Response data: $responseData');

      // Extract the token from the response
      String token = responseData['token'];

      // Store the token in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);
      SharedPreferecesServices.token = token;
      PageNavigations().pushAndRemoveUntill(const BottomNavigationScreen());
      log('Token stored in SharedPreferences: $token');
    } else {
      final responseData = jsonDecode(response.body);
      Get.snackbar("validation error", responseData['error']);
      log('Failed to verify OTP: ${response.body}');
    }
    return response;
  }
}
