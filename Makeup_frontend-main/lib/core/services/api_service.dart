import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'dart:typed_data';

const String baseUrl = 'https://leakfyp.pythonanywhere.com/api/';
// const String baseUrl = 'http://192.168.100.130:8000/api/'; // FOR DEBUGGING

class ApiService {
  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${baseUrl}auth/login/'),
      body: {'username': username, 'password': password},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['key'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return true;
    }
    return false;
  }

  static Future<Map<String, dynamic>> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception("No authentication token found.");
    }

    dynamic response = await http.get(
      Uri.parse('${baseUrl}username/'),
      headers: {'Authorization': 'Token $token'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get User Details: ${response.reasonPhrase}");
    }
  }

  static Future<Map<String, dynamic>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception("No authentication token found.");
    }

    dynamic response = await http.get(
      Uri.parse('${baseUrl}user/details/'),
      headers: {'Authorization': 'Token $token'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get User Details: ${response.reasonPhrase}");
    }
  }

  static Future<bool> updateUserDetails(String firstName, String lastName,
      String email, String age, String gender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception("No authentication token found.");
    }

    dynamic response = await http.post(
      Uri.parse('${baseUrl}user/update/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json', // Added Content-Type
      },
      body: json.encode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "age": age,
        "gender": gender,
      }),
    );
    return response.statusCode == 204;
  }

  static Future<Map<String, dynamic>> register(
      String username,
      String password1,
      String password2,
      String email,
      String firstName,
      String lastName) async {
    final response = await http.post(
      Uri.parse('${baseUrl}auth/registration/'),
      headers: {
        'Content-Type':
            'application/json', // Set Content-Type to application/json
      },
      body: json.encode({
        'username': username,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'password1': password1,
        'password2': password2,
      }),
    );
    if (response.statusCode == 204) {
      return {};
    }
    return json.decode(response.body);
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      await http.post(
        Uri.parse('${baseUrl}auth/logout/'),
        headers: {'Authorization': 'Token $token'},
      );
      await prefs.remove('token');
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      return false;
    }

    final response = await http.get(
      Uri.parse('${baseUrl}checkLogin/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );
    return response.statusCode == 204;
  }

  static Future<Uint8List?> uploadFile(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception("No authentication token found.");
    }

    try {
      // Create the multipart request
      var uri = Uri.parse('${baseUrl}upload/');
      var request = http.MultipartRequest('POST', uri);

      // Attach the file to the request
      var fileStream = http.MultipartFile(
        'file', // Key expected by the server
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: basename(file.path),
      );

      // Add headers and file
      request.headers['Authorization'] = 'Token $token';
      request.files.add(fileStream);

      // Send the request
      var response = await request.send();

      // Process the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Convert the response stream to Uint8List
        final Uint8List imageBytes = await response.stream.toBytes();

        // Return the image bytes
        return imageBytes;
      } else {
        // print("Failed to upload file: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // print("Error uploading file: $e");
      return null;
    }
  }
}
