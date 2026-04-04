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

  static Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {
    final res = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    return null;
  }

  static Future<bool> register(
    String username,
    String email,
    String password,
  ) async {
    final res = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    return res.statusCode == 200;
  }

  static Future<bool> updateUser(
    String email,
    String username,
    String password,
  ) async {
    final res = await http.put(
      Uri.parse("$baseUrl/update-user"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "username": username,
        "password": password,
      }),
    );

    return res.statusCode == 200;
  }

  static Future<void> savePaper(int userId, Map paper) async {
    await http.post(
      Uri.parse("$baseUrl/save-paper"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "title": paper["titles"],
        "authors": paper["authors"].toString(),
        "summary": paper["summaries"].toString(),
        "category": paper["category"],
        "terms": paper["terms"].toString(),
        "first_author": paper["first_author"],
        "published_date": paper["published_date"],
      }),
    );
  }

  static Future<List> getLibrary(int userId) async {
    final res = await http.get(Uri.parse("$baseUrl/get-library/$userId"));
    return jsonDecode(res.body);
  }

  static Future<void> deletePaper(int id) async {
    await http.delete(Uri.parse("$baseUrl/delete-paper/$id"));
  }

  static Future<Map<String, dynamic>> getUser(int userId) async {
    final res = await http.get(Uri.parse("$baseUrl/get-user/$userId"));
    return jsonDecode(res.body);
  }
}
