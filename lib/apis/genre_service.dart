import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/top_genre_dto.dart';
import 'api_const.dart';

class GenreService {
  Future<List<TopGenreDto>> fetchTopGenres() async {
    final apiUrl = '${ApiConst.baseUrl}api/genres/top6?limit=6';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
        final List<TopGenreDto> genres = jsonData.map((data) {
          return TopGenreDto.fromJson(data);
        }).toList();
        return genres;
      } else {
        throw Exception('Failed to load top genres');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
