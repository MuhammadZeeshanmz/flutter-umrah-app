import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSupportView extends StatefulWidget {
  const ContactSupportView({super.key});

  @override
  State<ContactSupportView> createState() => _ContactSupportViewState();
}

class _ContactSupportViewState extends State<ContactSupportView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // You could send data to a backend or Firebase here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message sent! Our team will get back soon.'),
        ),
      );
      _formKey.currentState!.reset();
    }
  }

  Future<void> _launchEmail() async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: 'support@umrahapp.com',
      query: 'subject=Support Request',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchWhatsApp() async {
    final whatsappUri = Uri.parse(
      "https://wa.me/966500000000?text=Hi,%20I%20need%20support",
    );
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact & Support',
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Need help? Contact our support team.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Contact Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(_nameController, 'Full Name'),
                  const SizedBox(height: 10),
                  _buildTextField(
                    _emailController,
                    'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(_subjectController, 'Subject'),
                  const SizedBox(height: 10),
                  _buildTextField(_messageController, 'Message', maxLines: 4),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send, color: Colors.deepPurple),
                    label: const Text(
                      'Send Message',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ),
            const Divider(height: 40),

            // Quick Actions
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email Support'),
              subtitle: const Text('support@umrahapp.com'),
              onTap: _launchEmail,
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('WhatsApp Support'),
              subtitle: const Text('+966 50 000 0000'),
              onTap: _launchWhatsApp,
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Live Chat'),
              subtitle: const Text('Connect with a support agent'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Live Chat is coming soon!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Office Address'),
              subtitle: const Text('123 Umrah Road, Makkah, Saudi Arabia'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    IconData icon;
    if (label == 'Email') {
      icon = Icons.email;
    } else if (label == 'Message') {
      icon = Icons.message;
    } else if (label == 'Subject') {
      icon = Icons.subject;
    } else {
      icon = Icons.person;
    }

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.deepPurple),
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.deepPurple.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label is required';
          }
          if (label == 'Email' && !value.contains('@')) {
            return 'Enter a valid email';
          }
          return null;
        },
      ),
    );
  }
}
