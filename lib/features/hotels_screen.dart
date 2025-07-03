import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelsBookingPage extends StatefulWidget {
  const HotelsBookingPage({super.key});

  @override
  State<HotelsBookingPage> createState() => _HotelsBookingPageState();
}

class _HotelsBookingPageState extends State<HotelsBookingPage> {
  final String _hotelUrl = 'https://www.example.com/hotels-booking';

  @override
  void initState() {
    super.initState();
    _launchHotelUrl();
  }

  Future<void> _launchHotelUrl() async {
    final Uri uri = Uri.parse(_hotelUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      Navigator.pop(context); // close the page after launching
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch the booking website')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading spinner while trying to launch
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
