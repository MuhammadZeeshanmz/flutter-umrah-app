import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TransportationView extends StatefulWidget {
  const TransportationView({super.key});

  @override
  State<TransportationView> createState() => _TransportationViewState();
}

class _TransportationViewState extends State<TransportationView> {
  final String _transportUrl =
      'https://your-hotel-or-transportation-website.com';

  @override
  void initState() {
    super.initState();
    _launchTransportUrl();
  }

  Future<void> _launchTransportUrl() async {
    final Uri uri = Uri.parse(_transportUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      Navigator.pop(context); // close this screen after launching
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open the transportation website'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
