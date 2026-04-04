import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("user_id");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Research Paper Recommender',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()), // ✅ loader
            );
          }

          final loggedIn = snapshot.data ?? false;

          return loggedIn ? HomeScreen.fromPrefs() : LoginScreen();
        },
      ), // ✅ FIRST SCREEN
    );
  }
}
