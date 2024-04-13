import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? _selectedOption; // Trạng thái để theo dõi thanh điều hướng được chọn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container chứa hình nền với hiệu ứng blur
          Container(

            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Hiệu ứng blur
              child: Container(
                color: Colors.black.withOpacity(0.7), // Màu nền mờ
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start, // Đặt thanh điều hướng vào lề bên trái
            crossAxisAlignment: CrossAxisAlignment.start, // Đảm bảo các thành phần được căn theo chiều ngang
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top), // Đặt khoảng cách bằng với phần padding của top
              Container(
                height: kToolbarHeight,
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white), // Icon mũi tên quay về
                      onPressed: () {
                        Navigator.pop(context); // Quay lại trang trước đó
                      },
                    ),
                    Text(
                      'Bộ lọc', // Hiển thị chữ "Bộ lọc"
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 48), // Khoảng cách giữa "Bộ lọc" và mũi tên
                  ],
                ),
              ),
              SizedBox(height: 16), // Khoảng cách giữa thanh điều hướng và nội dung khác
              // Thanh điều hướng
              Expanded(
                child: ListView(
                  children: [
                    NavigationOption(
                      title: 'Ngày cập nhật',
                      isSelected: _selectedOption == 'Ngày cập nhật',
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'Ngày cập nhật';
                        });
                      },
                    ),
                    Divider(),
                    NavigationOption(
                      title: 'Sắp sếp theo tên (A-Z)',
                      isSelected: _selectedOption == 'Sắp sếp theo tên (A-Z)',
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'Sắp sếp theo tên (A-Z)';
                        });
                      },
                    ),
                    Divider(),
                    NavigationOption(
                      title: 'Sắp xếp theo tên (Z-A)',
                      isSelected: _selectedOption == 'Sắp xếp theo tên (Z-A)',
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'Sắp xếp theo tên (Z-A)';
                        });
                      },
                    ),
                    Divider(),
                    NavigationOption(
                      title: 'Truyện mới',
                      isSelected: _selectedOption == 'Truyện mới',
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'Truyện mới';
                        });
                      },
                    ),
                    Divider(),
                    NavigationOption(
                      title: 'Top All',
                      isSelected: _selectedOption == 'Top All',
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'Top All';
                        });
                      },
                    ),
                    Divider(),
                    NavigationOption(
                      title: 'Top Tháng',
                      isSelected: _selectedOption == 'Top Tháng',
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'Top Tháng';
                        });
                      },
                    ),
                    Divider(),
                    NavigationOption(
                      title: 'Top Tuần',
                      isSelected: _selectedOption == 'Top Tuần',
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'Top Tuần';
                        });
                      },
                    ),
                    Divider(),
                    NavigationOption(
                      title: 'Top Ngày',
                      isSelected: _selectedOption == 'Top Ngày',
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'Top Ngày';
                        });
                      },
                    ),
                    Divider(),
                    NavigationOption(
                      title: 'Theo Dõi',
                      isSelected: _selectedOption == 'Theo Dõi',
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'Theo Dõi';
                        });
                      },
                    ),
                    Divider(),
                    NavigationOption(
                      title: 'Bình Luận',
                      isSelected: _selectedOption == 'Bình Luận',
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'Bình Luận';
                        });
                      },
                    ),
                    Divider(),
                    NavigationOption(
                      title: 'Số Chapter',
                      isSelected: _selectedOption == 'Số Chapter',
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'Số Chapter';
                        });
                      },
                    ),
                    Divider(),
                    NavigationOption(
                      title: 'Top Follow',
                      isSelected: _selectedOption == 'Top Follow',
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'Top Follow';
                        });
                      },
                    ),
                    // Thêm các NavigationOption khác tương tự ở đây
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NavigationOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  NavigationOption({
    required this.title,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check, color: Colors.white),
          ],
        ),
      ),
    );
  }
}