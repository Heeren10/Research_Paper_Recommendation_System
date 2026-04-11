import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateScreen extends StatefulWidget {
  final int userId;
  UpdateScreen({required this.userId});
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    final user = await ApiService.getUser(widget.userId);

    setState(() {
      email.text = user["email"];
      username.text = user["username"];
    });
  }

  void update() async {
    bool success = await ApiService.updateUser(
      email.text,
      username.text,
      password.text,
    );

    if (success) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("username", username.text);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Updated Successfully")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Profile"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Text(
                username.text.isNotEmpty ? username.text[0].toUpperCase() : "U",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: username,
              decoration: InputDecoration(
                labelText: "Username",
                prefixIcon: Icon(Icons.person),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "New Password",
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            SizedBox(height: 25),

            ElevatedButton(
              onPressed: update,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("Update Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
