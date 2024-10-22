import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/profile_model/profile_model.dart';
import 'package:gofriendsgo/services/profile_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:gofriendsgo/utils/constants/text_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

enum FromDates { dob, marriage }

class ProfileViewModel extends ChangeNotifier {
  final ProfileService _service = ProfileService();
  UserProfileModel? _profileResponse;
  bool _isLoading = false;
  bool _onEditPressed = false;
  
  String? _newMarriageAnniversary;

  // Separate variables for specific data
  String? userName;
  String? userEmail;
  String? userPhone;
  double? profilePercentage;
  String? profilePic;
  String? companyName;
  String? dob;
  String? frequentFlyerNo;
  String? additionalDetails;
  String? emailVerified;
  String? referral;
  String? source;
  String? specify;
  int? status;
  String? subString;  String? _newImagePath;

  UserProfileModel? get profileResponse => _profileResponse;
  bool get isLoading => _isLoading;
  String? get newImagePath => _newImagePath;
  bool get onEditPressed => _onEditPressed;

  String? get newMarriageAnniversary => _newMarriageAnniversary;

  addNewImage() async {
    final imagePath =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePath != null) {
      _newImagePath = imagePath.path;
    }
    notifyListeners();
  }

  disposing() {
    _newImagePath = null;
    _onEditPressed = false;
    _newMarriageAnniversary = null;
   
    notifyListeners();
    log("hey man");
  }

  void editButtonPressed() {
    _onEditPressed = true;
    log("gekki");
    notifyListeners();
  }

  Future<void> dateSelection(FromDates from, context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1996),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      final DateFormat formatter = DateFormat('d MMMM yyyy');
      final String formattedDate = formatter.format(selectedDate);

      from == FromDates.dob
          ? dob = formattedDate
          : _newMarriageAnniversary = formattedDate;
    }
    notifyListeners();
  }

  Future<void> fetchProfile() async {
    _isLoading = true;

    try {
      log(SharedPreferecesServices.token!);
      _profileResponse = await _service.fetchProfile();
      if (_profileResponse != null) {
        userName = _profileResponse!.data.user.name ?? '';
        userEmail = _profileResponse!.data.user.email ?? '';
        userPhone = _profileResponse!.data.user.phone ?? '';
        nameController.text = _profileResponse!.data.user.name ?? '';
        emailController.text = _profileResponse!.data.user.email ?? '';
        mobileController.text =
            _profileResponse!.data.user.phone ?? "";
        profilePic = _profileResponse!.data.user.profilePic ?? '';
        companyNameController.text =
            _profileResponse!.data.user.companyName ?? '';
        dob = _profileResponse!.data.user.dob;
        frequentController.text =
            _profileResponse!.data.user.frequentFlyerNo ?? '';
        additionalController.text =
            _profileResponse!.data.user.additionalDetails ?? '';
        emailVerified = _profileResponse!.data.user.emailVerifiedAt ?? '';
        emailVerified = _profileResponse!.data.user.profilePic ?? '';
        source = _profileResponse!.data.user.source ?? '';
        specify = _profileResponse!.data.user.specify ?? '';
        status = _profileResponse!.data.user.status ?? "";
        subString = userName!.substring(0, 2);
        calculateProfilePercentage() ;

        log('Profile fetched successfully');
        // log('User Name: $userName');
        // log('User Email: $userEmail');
        notifyListeners();
      }
    } catch (e) {
      log('Error fetching profile: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(int userId, updatedData) async {
    print('started');
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _service.updateUserProfile(
        userId,
        updatedData,
        SharedPreferecesServices.token!,
      );
      if (success) {
        log('Profile updated successfully');
        await fetchProfile(); // Refresh profile data after update
      } else {
        log('Failed to update profile');
        // Handle failure (e.g., show error message)
      }
    } catch (e) {
      log('Error updating profile: $e');
      // Handle any exceptions (e.g., show error message)
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void calculateProfilePercentage() {
    // ignore: unused_local_variable
    int nullCount = 0;
    int notNullCount = 0;

    // Check each variable
    List<String?> variables = [
      userName,
      userEmail,
      userPhone,
      profilePic,
      companyName,
      dob,
      frequentFlyerNo,
      additionalDetails,
      emailVerified,
      referral,
      source,
      specify,
    ];

    for (var variable in variables) {
      if (variable == null) {
        nullCount++;
      } else {
        notNullCount++;
      }
    }

    double ratio = notNullCount / variables.length;

    // Round to two decimal places and assign to profilePercentage
    profilePercentage = double.parse(ratio.toStringAsFixed(2));

    log('Profile completeness percentage: $profilePercentage');
  }
}
