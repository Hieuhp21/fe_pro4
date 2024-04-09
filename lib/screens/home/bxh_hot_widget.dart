import 'package:flutter/material.dart';
import 'package:sweet_peach_fe/screens/home/section_title_widget.dart';


class BxhHotWidget extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const BxhHotWidget({required this.title, required this.onTap});

  @override
  _BxhHotWidgetState createState() => _BxhHotWidgetState();
}

class _BxhHotWidgetState extends State<BxhHotWidget> {
  String _selectedRanking = 'Ngày';
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<List<String>> _rankings = [
    ['Ngày', 'BXH Ngày'],
    ['Tuần', 'BXH Tuần'],
    ['Tháng', 'BXH Tháng']
  ];

  List<List<Map<String, dynamic>>> _fakeRankings = [
    generateFakeRanking(10),
    generateFakeRanking(10),
    generateFakeRanking(10),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 500),
      child: Column(
        children: [
          SectionTitleWidget(
            title: widget.title,
            onTap: widget.onTap,
          ),
          ToggleButtons(
            isSelected: List.generate(_rankings.length, (index) => _rankings[index][0] == _selectedRanking),
            onPressed: (int index) {
              setState(() {
                _selectedRanking = _rankings[index][0];
                _currentPage = index;
                _pageController.jumpToPage(_currentPage);
              });
            },
            children: _rankings.map((ranking) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  ranking[1],
                  style: TextStyle(
                    color: ranking[0] == _selectedRanking ? Colors.white : Colors.white, // Màu chữ của button được chọn là trắng, ngược lại là đen
                  ),
                ),
              );
            }).toList(),
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey[300], // Màu nền của các button
            selectedColor: Colors.pinkAccent, // Màu của button được chọn
            fillColor: Colors.pink, // Màu nền của button được chọn
          ),

          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                  _selectedRanking = _rankings[_currentPage][0];
                });
              },
              children: [
                _buildRankingList(_fakeRankings[0]),
                _buildRankingList(_fakeRankings[1]),
                _buildRankingList(_fakeRankings[2]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static List<Map<String, dynamic>> generateFakeRanking(int length) {
    List<Map<String, dynamic>> fakeRanking = [];
    for (int i = 0; i < length; i++) {
      fakeRanking.add({
        'storyName': 'Story ${i + 1}',
        'coverImage': 'images/img1.jpg', // Thay đổi tên thuộc tính thành 'coverImage'
        'latestChapter': 'Chapter ${i + 1}',
        'timeAgo': '1 hour ago',
        'genres': ['Action', 'Adventure', 'Fantasy'],
        'views': 100045,
        'follows': 56400,
      });
    }
    return fakeRanking;
  }


  Widget _buildRankingList(List<Map<String, dynamic>> ranking) {
    return ListView.builder(
      itemCount: ranking.length,
      itemBuilder: (context, index) {
        return _buildItem(ranking[index]);
      },
    );
  }

  Widget _buildItem(Map<String, dynamic> story) {
    String storyName = story['storyName'] ?? ''; // Kiểm tra null trước khi sử dụng
    String coverImage = story['coverImage'] ?? '';
    String latestChapter = story['latestChapter'] ?? '';
    String timeAgo = story['timeAgo'] ?? '';
    List<String> genres = List.from(story['genres'] ?? []);
    int views = story['views'] ?? 0;
    int follows = story['follows'] ?? 0;

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), // Bo tròn ảnh
              color: Colors.grey[800], // Màu nền xám đậm
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15), // Bo tròn ảnh
              child: Image.asset(
                coverImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storyName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Chuyển màu chữ thành màu trắng
                  ),
                ),
                Text('$latestChapter | $timeAgo', style: TextStyle(color: Colors.grey)), // Chuyển màu chữ thành màu trắng
                SizedBox(height: 5),
                Wrap(
                  spacing: 5,
                  children: genres.map((genre) {
                    return _buildTag(genre);
                  }).toList(),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.remove_red_eye, color: Colors.greenAccent),
                    SizedBox(width: 5),
                    Text(_abbreviateNumber(views), style: TextStyle(color: Colors.grey)), // Áp dụng hàm _abbreviateNumber vào số views
                    Spacer(),
                    Icon(Icons.favorite, color: Colors.pinkAccent),
                    SizedBox(width: 5),
                    Text('${_abbreviateNumber(follows)} follows', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _abbreviateNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
