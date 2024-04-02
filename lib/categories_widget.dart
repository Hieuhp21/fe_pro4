import 'package:flutter/material.dart';
import 'section_title_widget.dart';

class CategoriesWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CategoriesWidget({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(
          title: title,
          onTap: onTap,
        ),
        _buildCategories(context),
      ],
    );
  }

  Widget _buildCategories(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 5/2, // Sử dụng tỷ lệ chiều rộng và chiều cao
        ),
        itemCount: 6, // Số lượng các mục trong lưới
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Xử lý khi nhấn vào một mục
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'Mục ${index + 1}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
