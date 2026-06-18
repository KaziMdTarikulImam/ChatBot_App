import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  /*
    Android Emulator:
    static const String baseUrl = "http://10.0.2.2:5050";

    iOS Simulator:
    static const String baseUrl = "http://127.0.0.1:5050";

    Real Phone:
    static const String baseUrl = "http://YOUR_COMPUTER_IP:5050";
  */

  static const String baseUrl = "https://chat.logicmatrix.us";

  static Future<String> postChatMessage({
    required String endpoint,
    required String sender,
    required String message,
  }) async {
    final Uri url = Uri.parse("$baseUrl/$endpoint");

    try {
      final response = await http
          .post(
            url,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
            body: jsonEncode({
              "sender": sender,
              "message": message,
            }),
          )
          .timeout(const Duration(seconds: 20));

      print("API URL: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.trim().isEmpty) {
          return "Empty response from server.";
        }

        final decodedData = jsonDecode(response.body);

        return _extractBotMessage(decodedData);
      } else {
        return "Server error: ${response.statusCode}";
      }
    } catch (e) {
      print("API Error: $e");
      return "Connection failed: $e";
    }
  }

  static String _extractBotMessage(dynamic decodedData) {
    /*
      Your backend response format:

      {
        "responses": [
          {
            "recipient_id": "mohsin",
            "text": "Good Afternoon! I'm Lia..."
          }
        ],
        "success": true
      }
    */

    if (decodedData is Map<String, dynamic>) {
      if (decodedData["responses"] != null && decodedData["responses"] is List) {
        final List responses = decodedData["responses"];

        if (responses.isEmpty) {
          return "No response from bot.";
        }

        return responses.map((item) {
          if (item is Map<String, dynamic>) {
            if (item["text"] != null) {
              return item["text"].toString();
            }

            if (item["message"] != null) {
              return item["message"].toString();
            }

            if (item["response"] != null) {
              return item["response"].toString();
            }

            if (item["reply"] != null) {
              return item["reply"].toString();
            }
          }

          return item.toString();
        }).join("\n");
      }

      if (decodedData["text"] != null) {
        return decodedData["text"].toString();
      }

      if (decodedData["message"] != null) {
        return decodedData["message"].toString();
      }

      if (decodedData["response"] != null) {
        return decodedData["response"].toString();
      }

      if (decodedData["reply"] != null) {
        return decodedData["reply"].toString();
      }

      if (decodedData["answer"] != null) {
        return decodedData["answer"].toString();
      }

      if (decodedData["bot"] != null) {
        return decodedData["bot"].toString();
      }

      return "No valid bot message found.";
    }

    if (decodedData is List) {
      if (decodedData.isEmpty) {
        return "No response from bot.";
      }

      return decodedData.map((item) {
        if (item is Map<String, dynamic>) {
          if (item["text"] != null) {
            return item["text"].toString();
          }

          if (item["message"] != null) {
            return item["message"].toString();
          }

          if (item["response"] != null) {
            return item["response"].toString();
          }

          if (item["reply"] != null) {
            return item["reply"].toString();
          }
        }

        return item.toString();
      }).join("\n");
    }

    return decodedData.toString();
  }
}