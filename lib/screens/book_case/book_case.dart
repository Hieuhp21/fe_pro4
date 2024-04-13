import 'package:flutter/material.dart';
import 'package:sweet_peach_fe/apis/history_service.dart';

import 'dart:ui';

import '../../models/comic.dart';
import '../comic/comic_list_view.dart';
import 'filter.dart';

class Bookcase extends StatefulWidget {
  @override
  _BookcaseState createState() => _BookcaseState();
}

class _BookcaseState extends State<Bookcase> {
  final List<String> _tabs = ["Lịch sử", "Theo dõi"];
  late List<Comic> _historyComics = [];
  late List<Comic> _followedComics = [];
  final HistoryService historyService = HistoryService();

  @override
  void initState() {
    super.initState();
    _fetchHistoryComics();
    _fetchFollowedComics();
  }

  Future<void> _fetchHistoryComics() async {
    try {
      List<Comic> fetchedComics = await historyService.getReadingHistory();
      setState(() {
        _historyComics = fetchedComics;
      });
    } catch (e) {
      print('Error fetching history comics: $e');
    }
  }

  Future<void> _fetchFollowedComics() async {
    // Logic để lấy danh sách truyện theo dõi
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: Stack(
          children: [
            // Background
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            // Main content
            Column(
              children: [
                // Title
                SizedBox(height: 200), // Placeholder for title
                // Search bar
                Container(
                  height: kToolbarHeight + 50,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Tìm kiếm...',
                              hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.5)),
                              prefixIcon: Icon(Icons.search, color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        IconButton(
                          icon: Icon(Icons.tune, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FilterPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // Tabs
                TabBar(
                  tabs: _tabs.map((String tab) {
                    return Tab(text: tab);
                  }).toList(),
                  labelColor: Colors.white,
                ),
                // Tab views
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: TabBarView(
                      children: [
                        ComicListView(comics: _historyComics),
                        ComicListView(comics: _followedComics),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Title (positioned at top)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 200,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'Bookcase',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}