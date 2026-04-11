import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<Map?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("user_id")) return null;

    return {
      "user_id": prefs.getInt("user_id"),
      "username": prefs.getString("username"),
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Research Paper Recommender',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          final user = snapshot.data;

          if (user == null) {
            return LoginScreen(); // ❌ not logged in
          }

          return HomeScreen(
            userId: user["user_id"],
            username: user["username"] ?? "User",
          );
        },
      ), // ✅ FIRST SCREEN
    );
  }
}
