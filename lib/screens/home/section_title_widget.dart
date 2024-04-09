import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SectionTitleWidget({required this.title, required this.onTap}) : super();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Spacer(),
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  'Nhiều hơn',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
