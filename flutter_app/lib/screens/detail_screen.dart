import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final Map paper;
  final int userId;

  const DetailScreen({super.key, required this.paper, required this.userId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isSaved = false; // ⭐ toggle state
  int? paperId;
  // 🔥 Reusable label-value widget
  Widget infoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.4,
          ),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkIfSaved();
  }

  void checkIfSaved() async {
    final list = await ApiService.getLibrary(widget.userId);

    for (var p in list) {
      if (p["title"] == widget.paper["titles"]) {
        setState(() {
          isSaved = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final paper = widget.paper;

    final summary = paper["summaries"]
        .toString()
        .replaceAll("\n", " ")
        .replaceAll(RegExp(r"\s+"), " ");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paper Details"),
        actions: [
          IconButton(
            icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () async {
              if (widget.userId == 0) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Please login first")));
                return;
              }

              if (!isSaved) {
                // ✅ SAVE
                paperId = await ApiService.savePaper(widget.userId, paper);

                setState(() {
                  isSaved = true;
                });

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Saved to library⭐")));
              } else {
                // ❌ DELETE

                if (paperId != null) {
                  // 🔥 fast way
                  await ApiService.deletePaper(paperId!);
                } else {
                  // 🔥 fallback (important)
                  final list = await ApiService.getLibrary(widget.userId);

                  final found = list.firstWhere(
                    (p) => p["title"] == paper["titles"],
                    orElse: () => null,
                  );
                  print("Deleting paperId: $paperId");
                  if (found != null) {
                    await ApiService.deletePaper(found["id"]);
                  }
                }

                setState(() {
                  isSaved = false;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Removed from library ❌")),
                );
              }
            },
          ),
        ],
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 1000, // 👈 controls width on large screens
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔥 Title
                    Text(
                      paper["titles"],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    infoText("Category", paper["category"]),
                    infoText("Terms", paper["terms"].toString()),
                    infoText("First Author", paper["first_author"]),
                    infoText("Authors", paper["authors"].toString()),
                    infoText("Published Date", paper["published_date"]),

                    const SizedBox(height: 16),

                    const Text(
                      "Summary",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      summary,
                      style: const TextStyle(height: 1.6),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
