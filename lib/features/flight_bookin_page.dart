import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FlightBookingPage extends StatefulWidget {
  const FlightBookingPage({super.key});

  @override
  State<FlightBookingPage> createState() => _FlightBookingPageState();
}

class _FlightBookingPageState extends State<FlightBookingPage> {
  final String _flightUrl = 'https://www.skyscanner.com/'; // Replace if needed

  @override
  void initState() {
    super.initState();
    _launchFlightUrl();
  }

  Future<void> _launchFlightUrl() async {
    final Uri uri = Uri.parse(_flightUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      Navigator.pop(context); // Close this screen after launching
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open the flight booking website'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
