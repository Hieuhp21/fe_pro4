import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sweet_peach_fe/apis/api_const.dart';
import '../models/comic.dart';

class NewestService {
  static Future<List<Comic>> fetchNewStories() async {
    final apiUrl = '${ApiConst.baseUrl}api/comics/newest1?limit=6';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));

        final List<Comic> newStories = jsonData.map((data) {
          return Comic.fromJson(data);
        }).toList();
        return newStories;
      } else {
        throw Exception('Failed to load new stories');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
