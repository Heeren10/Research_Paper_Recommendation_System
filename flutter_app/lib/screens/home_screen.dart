import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'results_screen.dart';
import 'update_screen.dart';
import 'library_screen.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final int userId;
  final String username;
  factory HomeScreen.fromPrefs() {
    // ignore: unnecessary_cast
    return HomeScreen(userId: 0, username: "User");
  }

  HomeScreen({required this.userId, required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  void search() async {
    final query = controller.text;

    if (query.isEmpty) return;

    final data = await ApiService.getRecommendations(query);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultsScreen(data: data, userId: widget.userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Research Recommender")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Welcome, ${widget.username}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter research topic",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: search,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),

            ListTile(
              title: Text("Library"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LibraryScreen(userId: widget.userId),
                  ),
                );
              },
            ),

            ListTile(
              title: Text("Update Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UpdateScreen(userId: widget.userId),
                  ),
                );
              },
            ),

            ListTile(
              title: Text("Logout"),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
