import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UmrahPagesView extends StatelessWidget {
  const UmrahPagesView({super.key});

  Future<void> _launchPDF() async {
    const pdfUrl =
        'https://example.com/umrah_guide.pdf'; // Replace with real link
    if (await canLaunchUrl(Uri.parse(pdfUrl))) {
      await launchUrl(Uri.parse(pdfUrl), mode: LaunchMode.externalApplication);
    }
  }

  void _showChecklistDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Umrah Checklist'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('✓ Valid Passport & Visa'),
                  Text('✓ Flight Tickets & Hotel Booking'),
                  Text('✓ Ihram Garments'),
                  Text('✓ Personal Hygiene Items'),
                  Text('✓ Prayer Mat, Tasbeeh, Duas'),
                  Text('✓ Medical Essentials'),
                  Text('✓ Power Bank & Chargers'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
    );
  }

  void _navigateToDetail(BuildContext context, String title, String content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(title: title, content: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final guideData = [
      {
        'title': 'Step-by-Step Umrah Guide',
        'content':
            '1. Enter Ihram\n2. Intention (Niyyah)\n3. Talbiyah Recitation\n4. Tawaf around Kaaba\n5. Sa’i between Safa and Marwah\n6. Hair Cutting/Shaving\n7. End Ihram',
      },
      {
        'title': 'Ihram Instructions',
        'content':
            'Wear two white unstitched cloths (men), clean clothing (women). Avoid perfumes. Perform ghusl, offer 2 rakats salah, and make niyyah.',
      },
      {
        'title': 'Do\'s and Don\'ts',
        'content':
            '✅ Be patient and kind\n✅ Follow local guidelines\n❌ Don’t argue or harm anyone\n❌ Avoid perfumes and cutting nails in Ihram',
      },
      {
        'title': 'Important Duas',
        'content':
            '• Talbiyah: “Labbayka Allahumma Labbayk..."\n• Dua at Hajar al-Aswad\n• Dua at Maqam Ibrahim\n• Dua between Safa and Marwah',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Umrah Guide',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          for (var item in guideData)
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.book),
                title: Text(item['title']!),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap:
                    () => _navigateToDetail(
                      context,
                      item['title']!,
                      item['content']!,
                    ),
              ),
            ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: const Text('Umrah Checklist'),
              onTap: () => _showChecklistDialog(context),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Download Full Umrah Guide (PDF)'),

              onTap: _launchPDF,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String content;

  const DetailPage({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(content, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
