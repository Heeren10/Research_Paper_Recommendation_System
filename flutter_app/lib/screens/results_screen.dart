import 'package:flutter/material.dart';
import 'detail_screen.dart';

class ResultsScreen extends StatelessWidget {
  final Map data;
  final int userId;

  ResultsScreen({required this.data, required this.userId});

  @override
  Widget build(BuildContext context) {
    final papers = data["recommendations"];

    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: ListView.builder(
        itemCount: papers.length,
        itemBuilder: (context, index) {
          final paper = papers[index];

          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.all(12),
              title: Text(
                paper["titles"],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                paper["authors"].toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(paper: paper, userId: userId),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
