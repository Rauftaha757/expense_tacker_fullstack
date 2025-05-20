import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const base_url = "http://10.0.2.2:3000";

  Future<Map<String, dynamic>> expense_inserter(
      double amount,
      String note,
      String date,
      double salary,
      ) async {
    final url = Uri.parse("$base_url/api/expense");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "amount": amount,
          "note": note,
          "date": date,
          "salary": salary,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        return {
          'success': false,
          'message': jsonDecode(response.body)['error'] ?? 'Unknown error',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}
