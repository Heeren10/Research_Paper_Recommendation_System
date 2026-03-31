import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'results_screen.dart';

class HomeScreen extends StatefulWidget {
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
      MaterialPageRoute(builder: (_) => ResultsScreen(data: data)),
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
    );
  }
}
