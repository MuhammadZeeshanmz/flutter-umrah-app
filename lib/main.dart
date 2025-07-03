import 'package:flutter/material.dart';
import 'package:umrah_app/home/home_view.dart';
import 'package:umrah_app/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      // ✅ Set initial route
      initialRoute: '/login',

      // ✅ Define routes
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeView(),
      },
    );
  }
}
