import 'package:flutter/material.dart';

import '../../apis/api_const.dart';
import '../../apis/chapter_service.dart';
import '../../apis/history_service.dart';
import '../../models/image_chapter.dart';

class ChapterDetailScreen extends StatefulWidget {
  final int chapterId;
  final List<Map<String, dynamic>> chapters;
  final int comicId;
  ChapterDetailScreen({required this.chapterId, required this.chapters,  required this.comicId});

  @override
  _ChapterDetailScreenState createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  final historyService= HistoryService();
  final chapterService = ChapterService();
  late ScrollController _scrollController;
  int currentChapterId =1;
  bool isFavorite = false;
  bool isFilterVisible = false;
  String selectedSortingOption = 'Mới nhất';
  bool isAutoScrolling = false;
  List<ImageChapter> images = [];

  @override
  void initState() {
    super.initState();
    currentChapterId = widget.chapterId;
    fetchChapterImages(currentChapterId);

    _scrollController = ScrollController();

  }
  void _startAutoScroll() {
    double currentOffset = _scrollController.offset;
    double viewportHeight = MediaQuery.of(context).size.height*0.8;
    double targetOffset = currentOffset + viewportHeight;
    isAutoScrolling = true;
    _scrollController.animateTo(
      targetOffset,
      duration: Duration(seconds: 2),
      curve: Curves.ease,
    );
  }
  void _stopAutoScroll() {
    isAutoScrolling = false;
  }
  Future<void> _autoScroll() async {
    while (isAutoScrolling) {
      await Future.delayed(Duration(seconds: 5));
      if (isAutoScrolling) {
        _startAutoScroll();
      }
    }
  }
  Future<void> addReadingHistory(int chapterId) async {
    // Đợi kết quả của historyService.addReadingHistory
    await historyService.addReadingHistory(widget.comicId, chapterId);
  }
  Future<void> incrementViewCount(int chapterId) async {

    await chapterService.incrementViewCount(chapterId) ;
  }
  Future<void> fetchChapterImages(int chapterId) async {
    try {
      List<ImageChapter> fetchedImages =
      await chapterService.getImagesChapterByChapterId(chapterId);
      setState(() {
        images = fetchedImages;
      });
      await addReadingHistory(chapterId);
      await incrementViewCount(chapterId);
    } catch (e) {
      print('Error fetching chapter images: $e');
    }
  }

  void toggleFilterVisibility() {
    setState(() {
      isFilterVisible = !isFilterVisible;
    });
  }
  void sortChapters(String option) {
    setState(() {
      selectedSortingOption = option;
      if (option == 'Cũ nhất') {
        widget.chapters.sort((a, b) => a['chapterId'].compareTo(b['chapterId']));
      } else {
        widget.chapters.sort((a, b) => b['chapterId'].compareTo(a['chapterId']));
      }
    });
  }

  void onChapterSelected(int chapterId) {
    setState(() {
      currentChapterId = chapterId;
      isFilterVisible = false; // Đóng toggle khi chọn một chương
    });
    fetchChapterImages(currentChapterId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Bọc toàn bộ nội dung trong GestureDetector
      onTap: () {
        setState(() {
          isFilterVisible = false; // Đóng toggle khi bấm bên ngoài toggle
        });
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.black,
                title: Text(
                  widget.chapters[widget.chapterId]['title'],
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                centerTitle: true,
                floating: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ],
              ),
            ];
          },
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            ApiConst.baseUrl + 'images/' + images[index].imagePath,
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              isFilterVisible ?   Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height:  MediaQuery.of(context).size.height * 0.5 ,
                  color: Colors.black,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                sortChapters('Cũ nhất');
                              },
                              child: Text(
                                'Cũ nhất',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  selectedSortingOption == 'Cũ nhất' ? Colors.red : Colors.grey,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                sortChapters('Mới nhất');
                              },
                              child: Text(
                                'Mới nhất',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  selectedSortingOption == 'Mới nhất' ? Colors.red : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.chapters.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                widget.chapters[index]['title'],
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                onChapterSelected(widget.chapters[index]['chapterId']);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ):Container(),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  setState(() {
                    currentChapterId--;
                  });
                  fetchChapterImages(currentChapterId);
                },
              ),
              IconButton(
                icon: Icon(Icons.filter_list, color: Colors.white),
                onPressed: () {
                  toggleFilterVisibility();
                },
              ),
              IconButton(
                icon: Icon(
                  isAutoScrolling ? Icons.stop: Icons.play_arrow  ,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (isAutoScrolling) {
                      _stopAutoScroll();
                    } else {
                      _startAutoScroll();
                      _autoScroll();
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: () {
                  setState(() {
                    currentChapterId++;
                  });
                  fetchChapterImages(currentChapterId);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}