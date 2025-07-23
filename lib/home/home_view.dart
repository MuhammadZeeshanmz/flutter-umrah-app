import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:umrah_app/features/contact_support.dart';
import 'package:umrah_app/features/flight_bookin_page.dart';
import 'package:umrah_app/features/hotels_screen.dart';
import 'package:umrah_app/features/shop_essenatial_view.dart';
import 'package:umrah_app/features/transportation_view.dart';
import 'package:umrah_app/features/umrah_pages_view.dart';
import 'package:umrah_app/features/umrah_qa_screen.dart';
import 'package:umrah_app/features/visa_services_screen.dart';
import 'package:umrah_app/features/travelers_guide_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String _name = "User";
  String _email = "email";

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // This line is now valid
  }

  // fetch user data
  Future<void> _fetchUserData() async {
    try {
      User? user = auth.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          setState(() {
            _name = userDoc['name'] ?? "User";
            _email = userDoc['email'] ?? "Email";
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _deleteUserAccount() async {
    try {
      User? user = auth.currentUser;

      if (user != null) {
        // Delete the Firestore document
        await firestore.collection('users').doc(user.uid).delete();

        // Delete the user account from Firebase Auth
        await user.delete();

        // Sign out after deletion
        await auth.signOut();

        // Navigate to login screen
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      print("Error deleting user account: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Failed to delete account. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "UMS",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Greeting Banner
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Assalamu Alaikum",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Welcome to your Umrah guide and services app!",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.4, // More wide, less tall

              children: [
                _buildFeatureTile('assets/visa.webp', "Visa Services", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VisaServicesScreen(),
                    ),
                  );
                }),

                _buildFeatureTile('assets/hotel.jpg', "Hotels", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HotelsBookingPage(),
                    ),
                  );
                }),
                _buildFeatureTile('assets/fl.webp', "Flights", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FlightBookingPage(),
                    ),
                  );
                }),
                _buildFeatureTile('assets/ee.jpg', "Shop Essentials", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShoeEssentialView(),
                    ),
                  );
                }),
                _buildFeatureTile('assets/trans.jpg', "Transportation", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransportationView(),
                    ),
                  );
                }),
                _buildFeatureTile('assets/tt.jpg', "Traveler’s Guide", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TravelersGuideView(),
                    ),
                  );
                }),
                _buildFeatureTile('assets/cc.jpg', "Contact/Support", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactSupportView(),
                    ),
                  );
                }),
                _buildFeatureTile('assets/um.webp', "Umrah Packages", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UmrahPagesView(),
                    ),
                  );
                }),
                _buildFeatureTile('assets/qa.jpg', "Umrah Q&A", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UmrahQAScreen()),
                  );
                }),
              ],
            ),

            const SizedBox(height: 30),

            // Special Offer Section
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Book Early!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Get discounts on early Umrah bookings",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.discount, color: Colors.white, size: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile(String imagePath, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover, // fills the entire container
              ),
              Container(
                color: Colors.black.withOpacity(0.4), // optional dark overlay
              ),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
