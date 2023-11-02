import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  try {
    await fetchRandomUserData();
  } catch (e) {
    print("error: $e");
  }
}

Future<void> fetchRandomUserData() async {
  final apiUrl = Uri.parse("https://random-data-api.com/api/users/random_user?size=10");
  final response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    if (data is List) {
      for (var user in data) {
        final uid = user['uid'];
        final firstName = user['first_name'];
        final lastName = user['last_name'];

        final userString = "UID: $uid, Full-Name: $firstName $lastName";
        print(userString);
      }
    } else {
      print("unexpected response.");
    }
  } else {
    print("request failed.... status code: ${response.statusCode}");
  }
}
