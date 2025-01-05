import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scorecontroller/database/ip_storage.dart';


class ApiService {
  final IPStorageService _ipStorageService = IPStorageService();

  String get baseUrl {
    return _ipStorageService.getIp();
   }

  Future<void> sendScoreUpdate(String team, int score) async {
    final url = Uri.parse('$baseUrl/score/update');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'team': team, 'score': score}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update score: ${response.body}');
      }
    } catch (e) {
      print('Error updating score: $e');
    }
  }

 Future<void> updateTimer(int remainingTime) async {
    final url = Uri.parse('$baseUrl/timer/update');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'remainingTime': remainingTime}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update timer: ${response.body}');
      }
    } catch (e) {
      print('Error updating timer: $e');
    }
  }

 Future<void> sendTeamName(String team, String name) async {
    final url = Uri.parse('$baseUrl/team/name');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'team': team, 'name': name}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update team name: ${response.body}');
      }
    } catch (e) {
      print('Error updating team name: $e');
    }
  }


  Future<void> toggleButton(String side) async {
    final url = Uri.parse('$baseUrl/button/toggle');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'side': side}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to toggle button: ${response.body}');
      }
    } catch (e) {
      print('Error toggling button: $e');
    }
  }
}
