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
      appBar: AppBar(title: Text("Update Profile")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: username,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(labelText: "New Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: update, child: Text("Update")),
          ],
        ),
      ),
    );
  }
}
