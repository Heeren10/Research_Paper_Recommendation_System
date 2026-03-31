import 'package:flutter/material.dart';
import 'detail_screen.dart';

class ResultsScreen extends StatelessWidget {
  final Map data;

  ResultsScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    final papers = data["recommendations"];

    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: ListView.builder(
        itemCount: papers.length,
        itemBuilder: (context, index) {
          final paper = papers[index];

          return ListTile(
            title: Text(paper["titles"]),
            subtitle: Text(paper["authors"].toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailScreen(paper: paper)),
              );
            },
          );
        },
      ),
    );
  }
}
