import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  final int userId;

  LibraryScreen({required this.userId});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List papers = [];

  @override
  void initState() {
    super.initState();
    loadLibrary();
  }

  void loadLibrary() async {
    final data = await ApiService.getLibrary(widget.userId);
    setState(() {
      papers = data;
    });
  }

  void deletePaper(int id) async {
    await ApiService.deletePaper(id);
    loadLibrary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Library")),
      body: ListView.builder(
        itemCount: papers.length,
        itemBuilder: (context, index) {
          final paper = papers[index];

          return Card(
            child: ListTile(
              title: Text(paper["title"]),
              subtitle: Text(paper["authors"]),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deletePaper(paper["id"]),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(
                      paper: {
                        "titles": paper["title"],
                        "authors": paper["authors"],
                        "summaries": paper["summary"],
                        "category": paper["category"],
                        "terms": paper["terms"],
                        "first_author": paper["first_author"],
                        "published_date": paper["published_date"],
                      },
                      userId: widget.userId,
                    ),
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
