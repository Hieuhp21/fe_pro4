import 'package:flutter/material.dart';
import 'section_title_widget.dart';

class NewStoriesWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const NewStoriesWidget({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(
          title: title,
          onTap: onTap,
        ),
        SizedBox(height: 16),
        _buildNewStories(context), // Truyền context vào hàm _buildNewStories
      ],
    );
  }

  Widget _buildNewStories(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width * 0.33; // Đặt chiều rộng của mỗi phần tử

    // Dữ liệu giả mạo cho các truyện
    List<Map<String, dynamic>> fakeData = [
      {
        'title': 'TA TRỜI SINH ĐÃ LÀ NHÂN VẬT PHẢN DIỆN',
        'latestChapter': 24,
        'timeAgo': 3,
        'coverImageUrl': 'images/img1.jpg', // URL hình ảnh bìa
      },
      {
        'title': 'Truyện số 2',
        'latestChapter': 15,
        'timeAgo': 5,
        'coverImageUrl': 'images/img2.jpg', // URL hình ảnh bìa
      },
      {
        'title': 'Truyện số 1',
        'latestChapter': 24,
        'timeAgo': 3,
        'coverImageUrl': 'images/img2.jpg', // URL hình ảnh bìa
      },
      {
        'title': 'Truyện số 2',
        'latestChapter': 15,
        'timeAgo': 5,
        'coverImageUrl': 'images/img2.jpg', // URL hình ảnh bìa
      },
      {
        'title': 'Truyện số 1',
        'latestChapter': 24,
        'timeAgo': 3,
        'coverImageUrl': 'images/img2.jpg', // URL hình ảnh bìa
      },
      {
        'title': 'Truyện số 2',
        'latestChapter': 15,
        'timeAgo': 5,
        'coverImageUrl': 'images/img2.jpg', // URL hình ảnh bìa
      },
      // Thêm dữ liệu cho các truyện khác nếu cần
    ];

    return Container(
      height: 160,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: fakeData.map((data) {
            return GestureDetector(
              onTap: () {
                // Xử lý khi nhấn vào truyện mới
              },
              child: Container(
                width: itemWidth,
                margin: const EdgeInsets.only(left: 14, right: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), // Bo góc cho container
                  //color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                          image: DecorationImage(
                            image: AssetImage(data['coverImageUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data['title'], // Sử dụng tiêu đề từ dữ liệu giả mạo
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12, // Giảm kích thước của chữ
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            Row(
                              children: [
                                Text(
                                  'Chapter ${data['latestChapter']}  ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10, // Giảm cỡ chữ
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                Text(
                                  '${data['timeAgo']}h',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10, // Giảm cỡ chữ
                                    fontWeight: FontWeight.bold, // In đậm
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
