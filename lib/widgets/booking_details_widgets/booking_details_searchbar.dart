import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/view_model/bookings_viewmodel.dart';
import 'package:provider/provider.dart';

class BookingDetailsSearch extends StatelessWidget {
  const BookingDetailsSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: mediaquerywidth(0.04, context),
          right: mediaquerywidth(0.04, context)),
      child: SizedBox(
        height: mediaqueryheight(0.06, context),
        child: SearchBar(
          onChanged: (value) {
            context.read<BookingViewModel>().filterBookings(value);
          },
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          hintText: 'Search Your Bookings',
        ),
      ),
    );
  }
}
