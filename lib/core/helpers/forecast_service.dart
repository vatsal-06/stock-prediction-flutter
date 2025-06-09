import 'dart:convert';
import 'package:http/http.dart' as http;

class ForecastService {
  final String apiUrl = "https://stockpredictionbackend.onrender.com/forecast";

  Future<List<Map<String, dynamic>>> getForecast(List<Map<String, dynamic>> history, {int periods = 7}) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "history": history,
        "periods": periods,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      return result.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to fetch forecast: ${response.body}");
    }
  }
}
