import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String baseUrl = "http://10.0.2.2:8000"; // emulator
  static const String baseUrl = "http://127.0.0.1:8000"; // Web

  static Future<Map<String, dynamic>> getRecommendations(String query) async {
    final response = await http.post(
      Uri.parse("$baseUrl/recommend"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"query": query, "top_k": 15}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error");
    }
  }
}
