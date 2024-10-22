import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/model/bookings_model/bookings_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class BookingService {
  Future<BookingResponse> fetchBookings(String token) async {
    log('Fetching bookings from service file');
    try {
      final response = await http.get(
        Uri.parse('${API.baseUrl}/bookings'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return BookingResponse.fromJson(parsed);
      } else {
        log('Error: Failed to load bookings with status code ${response.statusCode}');
        throw Exception(
            'Failed to load bookings. Error from booking service area.');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to load bookings: $e');
    }
  }
}
