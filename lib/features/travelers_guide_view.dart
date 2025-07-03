import 'package:flutter/material.dart';

class TravelersGuideView extends StatefulWidget {
  const TravelersGuideView({super.key});

  @override
  State<TravelersGuideView> createState() => _TravelersGuideViewState();
}

class _TravelersGuideViewState extends State<TravelersGuideView> {
  final List<Map<String, dynamic>> guideSections = [
    {
      'title': 'Before Travel',
      'icon': Icons.flight_takeoff,
      'details': [
        'Ensure passport & visa validity.',
        'Get recommended vaccinations.',
        'Make photocopies of important documents.',
        'Install travel apps and download offline maps.',
        'Exchange currency or carry international card.',
      ],
    },
    {
      'title': 'During Travel',
      'icon': Icons.airplanemode_active,
      'details': [
        'Arrive at airport early.',
        'Keep emergency contacts handy.',
        'Stay hydrated & walk during long flights.',
        'Keep essentials like chargers, medication, snacks.',
      ],
    },
    {
      'title': 'At Destination',
      'icon': Icons.location_on,
      'details': [
        'Respect local laws and customs.',
        'Stay connected with your group or travel leader.',
        'Avoid unsafe areas and carry hotel contact card.',
        'Drink bottled water and eat safe food.',
      ],
    },
    {
      'title': 'Emergency Tips',
      'icon': Icons.warning_amber,
      'details': [
        'Know embassy or consulate location.',
        'Dial local emergency numbers if needed.',
        'Use GPS and translation apps.',
        'Always keep backup cash hidden.',
      ],
    },
  ];

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredSections =
        guideSections
            .where(
              (section) => section['title'].toLowerCase().contains(
                searchText.toLowerCase(),
              ),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Traveler\'s Guide',
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
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(30),
              child: TextField(
                onChanged: (value) => setState(() => searchText = value),
                decoration: InputDecoration(
                  hintText: 'Search Guide Section...',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.deepPurple,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.deepPurple.shade100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Guide Sections
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: filteredSections.length,
              itemBuilder: (context, index) {
                final section = filteredSections[index];
                return GuideCard(
                  title: section['title'],
                  icon: section['icon'],
                  details: List<String>.from(section['details']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GuideCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<String> details;

  const GuideCard({
    super.key,
    required this.title,
    required this.icon,
    required this.details,
  });

  @override
  State<GuideCard> createState() => _GuideCardState();
}

class _GuideCardState extends State<GuideCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Icon(widget.icon, color: Colors.blueAccent),
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
        onExpansionChanged: (value) => setState(() => isExpanded = value),
        children:
            widget.details
                .map(
                  (tip) => ListTile(
                    leading: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.deepPurple,
                    ),
                    title: Text(tip),
                  ),
                )
                .toList(),
      ),
    );
  }
}
