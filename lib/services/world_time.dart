import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  final String location;
  final String flag;
  final String url;
  String? time;
  bool? isDayTime;

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getData() async {
    try {
      final response = await get(
        Uri.parse(
          'https://timeapi.io/api/time/current/zone?timeZone=$url',
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load time data');
      }

      final Map<String, dynamic> data = jsonDecode(response.body);
      final String dateTime = data['dateTime'];

      final DateTime now = DateTime.parse(dateTime);
      isDayTime = now.hour > 6 && now.hour < 20;
      time = DateFormat.jm().format(now);

    } catch (e) {
      print('Error: $e');
      time = "Couldn't get time data";
      isDayTime = false;
    }
  }
}