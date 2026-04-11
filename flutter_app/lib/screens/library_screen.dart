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
      appBar: AppBar(title: Text("My Library"), centerTitle: true),
      body: papers.isEmpty
          ? Center(
              child: Text(
                "No saved papers yet 📄",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: papers.length,
              itemBuilder: (context, index) {
                final paper = papers[index];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    title: Text(
                      paper["title"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        paper["authors"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
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
