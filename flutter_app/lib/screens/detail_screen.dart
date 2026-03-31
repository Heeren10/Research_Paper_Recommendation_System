import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Map paper;

  const DetailScreen({super.key, required this.paper});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isSaved = false; // ⭐ toggle state

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
            onPressed: () {
              setState(() {
                isSaved = !isSaved;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isSaved ? "Saved to library ⭐" : "Removed from library",
                  ),
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔥 Title
                Text(
                  paper["titles"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // 🔥 Info Section
                infoText("Category", paper["category"]),
                infoText("Terms", paper["terms"].toString()),
                infoText("First Author", paper["first_author"]),
                infoText("Authors", paper["authors"].toString()),
                infoText("Published Date", paper["published_date"]),

                const SizedBox(height: 16),

                // 🔥 Summary Title
                const Text(
                  "Summary",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                // 🔥 Summary Content
                Text(
                  summary,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
