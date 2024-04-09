import 'package:flutter/material.dart';

class NewStoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Truyện mới'),
      ),
      body: Container(
        // Hiển thị danh sách truyện mới ở đây
        child: Center(
          child: Text('Danh sách truyện mới'),
        ),
      ),
    );
  }
}
