import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sweet_peach_fe/apis/api_const.dart';
import '../../apis/comment_service.dart';
import '../../models/comment.dart';

class CommentScreen extends StatefulWidget {
  final int chapterId;
  final int comicId;
  CommentScreen({required this.chapterId, required this.comicId});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late List<Comment> comments = [];
  bool isLoading = false;
  TextEditingController _commentController = TextEditingController();
  final  commentService = CommentService();
  @override
  void initState() {
    super.initState();
    fetchComments(widget.chapterId);
    print('aaaa: ${comments}');
  }

  Future<void> fetchComments(int chapterId) async {
    try {
      setState(() {
        isLoading = true; // Hiển thị CircularProgressIndicator
      });

      List<Comment> fetchedComment = await commentService.fetchComments(chapterId);
      setState(() {
        comments = fetchedComment;
      });
    } catch (e) {
      print("fail load comment $e");
      // Hiển thị thông báo lỗi cho người dùng nếu cần
    } finally {
      setState(() {
        isLoading = false; // Ẩn CircularProgressIndicator
      });
    }
  }

  Future<void> postComment(int chapterId,int comicId, String comment) async {
    try {
       await commentService.postComment(chapterId,comicId, comment);
        fetchComments(widget.chapterId);


    } catch (e) {
      print("Failed to post comment: $e");
      // Hiển thị thông báo lỗi cho người dùng nếu cần
    }
  }
  DateFormat dateFormat = DateFormat('HH:mm - dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child:  isLoading ? Center(child: CircularProgressIndicator())
            :ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {

            String createdAtString = comments[index].createdAt as String;
            DateTime createdAtDateTime = DateTime.parse(createdAtString);
            String formattedDate = dateFormat.format(createdAtDateTime);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _getRandomColor(), // Lấy màu ngẫu nhiên cho khung avatar
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              '${ApiConst.baseUrl}images/${comments[index].avatar}'
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Icon(
                            Icons.flare_sharp,
                            color: Colors.yellow, // Màu của biểu tượng
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 8), // Add spacing between avatar and comment
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    comments[index].username,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(comments[index].content),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Thêm bình luận...',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send,color: Colors.blue ),
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    postComment(widget.chapterId,widget.comicId, _commentController.text);
                    _commentController.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getRandomColor() {
    // Tạo một màu ngẫu nhiên
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
