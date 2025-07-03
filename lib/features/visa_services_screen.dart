import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VisaServicesScreen extends StatefulWidget {
  const VisaServicesScreen({super.key});

  @override
  State<VisaServicesScreen> createState() => _VisaServicesScreenState();
}

class _VisaServicesScreenState extends State<VisaServicesScreen> {
  bool isApplied = false;
  String trackingNumber = "";

  final _documentController = TextEditingController();

  void _applyForVisa() async {
    const url = 'https://www.saudiembassy.net/hajj-and-umrah-visa';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch visa website")),
      );
    }
  }

  @override
  void dispose() {
    _documentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Visa Services",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("Visa Requirements"),
          _buildTextCard(
            "• Valid passport (minimum 6 months)\n"
            "• Passport-sized photos\n"
            "• Confirmed flight and hotel bookings\n"
            "• Proof of relationship (for women under 45)\n"
            "• Vaccination certificates\n"
            "• Travel insurance (COVID-19 coverage)",
          ),
          const SizedBox(height: 20),

          _buildSectionTitle("How to Apply"),
          _buildTextCard(
            "1. Collect required documents\n"
            "2. Fill out visa application form\n"
            "3. Upload your documents below\n"
            "4. Submit your application\n"
            "5. Track application status here",
          ),
          const SizedBox(height: 20),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: _applyForVisa,
            icon: const Icon(Icons.send, color: Colors.white),
            label: const Text(
              "Apply for Visa",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  Widget _buildTextCard(String text) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(text, style: const TextStyle(fontSize: 15)),
      ),
    );
  }
}
