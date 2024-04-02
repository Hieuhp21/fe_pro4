import 'package:flutter/material.dart';

class RecommendedStoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đề xuất của bạn'),
      ),
      body: Container(
        // Hiển thị danh sách truyện đề xuất ở đây
        child: Center(
          child: Text('Danh sách truyện đề xuất'),
        ),
      ),
    );
  }
}
