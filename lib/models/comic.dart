class Comic {
  final int comicId;
  final String title;
  final String imageUrl;
  final String lastChapter;
  final String timeSinceAdded;
  final int views;
  final int follows;


  Comic({
    required this.comicId,
    required this.title,
    required this.imageUrl,
    required this.lastChapter ,
    required this.timeSinceAdded,
    required this.views,
    required this.follows,

  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      comicId: json['id'],
      title: json['title'],
      imageUrl: json['coverImage'],
      lastChapter: json['latestChapterTitle'],
      timeSinceAdded: json['timeSinceLastUpdate'],
      views: json['viewCount'],
      follows: json['followCount'],

    );
  }
}

//List<Comic> comicList = jsonData.map((json) => Comic.fromJson(json)).toList();