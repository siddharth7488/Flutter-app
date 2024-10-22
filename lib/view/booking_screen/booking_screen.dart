import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/bookings_model/bookings_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_bar.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view_model/bookings_viewmodel.dart';
import 'package:gofriendsgo/widgets/booking_details_widgets/booking_details_container.dart';
import 'package:gofriendsgo/widgets/booking_details_widgets/booking_details_searchbar.dart';
import 'package:provider/provider.dart';

class BookingDetailsScreen extends StatefulWidget {
  final bool fromBottomNav;
  const BookingDetailsScreen({super.key, required this.fromBottomNav});


  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  List<BookingModel> bookings =[
    BookingModel(
      id: 1,
      chatId: 101,
      userName: 'Mr Aigha Kunha',
      amount: '₹ 5568',
      sector: 'The Lalit Great Eastern Kolkata',
      services: 'Hotel Booking',
      ticket: 'The Lalit Great Eastern Kolkata',
      createdAt: DateTime.parse('2024-05-02'),
      updatedAt: DateTime.now(),
    ),
    BookingModel(
      id: 2,
      chatId: 102,
      userName: 'Mr Aigha Kunha',
      amount: '₹ 5568',
      sector: 'The Lalit Great Eastern Kolkata',
      services: 'Hotel Booking',
      ticket: 'The Lalit Great Eastern Kolkata',
      createdAt: DateTime.parse('2024-04-25'),
      updatedAt: DateTime.now(),
    ),
    BookingModel(
      id: 3,
      chatId: 103,
      userName: 'Mr Aigha Kunha',
      amount: '₹ 5568',
      sector: 'The Lalit Great Eastern Kolkata',
      services: 'Hotel Booking',
      ticket: 'The Lalit Great Eastern Kolkata',
      createdAt: DateTime.parse('2024-04-25'),
      updatedAt: DateTime.now(),
    )
  ];
  @override
  void initState() {
    context.read<BookingViewModel>().fetchBookingsfromservice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, mediaqueryheight(0.1, context)),
          child: CommonGradientAppBar(
            heading: "Bookings",
            fromBottomNav: widget.fromBottomNav,
          )),
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<BookingViewModel>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              const CustomSizedBoxHeight(0.03),
              const BookingDetailsSearch(),
              const CustomSizedBoxHeight(0.02),
              BookingDetailsContainer(bookings),
            ],
          ),
        );
      }),
    );
  }
}
class BookingDetailsList extends StatelessWidget {
  final List<Booking> bookings;

  const BookingDetailsList(this.bookings, {super.key});

  @override
  Widget build(BuildContext context) {
    // Use ListView.builder directly without wrapping in SingleChildScrollView
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return BookingCard(booking);
      },
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard(this.booking, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.hotelName, // "The Lalit Great Eastern Kolkata"
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    booking.guestName, // "Mr Aigha Kunha"
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    booking.bookingDate, // "02-May-2024"
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹ ${booking.amount}', // "₹ 5,568"
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  IconButton(
                    icon: const Icon(Icons.download_rounded, color: Colors.purple),
                    onPressed: () {
                      // Implement download action here
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Booking {
  final String hotelName;
  final String guestName;
  final String bookingDate;
  final String amount;

  Booking({
    required this.hotelName,
    required this.guestName,
    required this.bookingDate,
    required this.amount,
  });
}


