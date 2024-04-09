import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sweet_peach_fe/apis/api_const.dart';

import '../dtos/comic_dto.dart';

class ComicService {
  Future<ComicDto> fetchComic(int comicId) async {
    final apiUrl = '${ApiConst.baseUrl}api/comics/$comicId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        return ComicDto.fromJson(jsonData);
      } else {
        throw Exception('Failed to load comic');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
