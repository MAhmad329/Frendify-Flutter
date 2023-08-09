import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Screens/myprofile_screen.dart';
import 'package:frendify/constants.dart';
import 'package:frendify/Models/comments_model.dart';
import 'package:frendify/widgets/text_input.dart';
import '../Authentication/auth.dart';
import 'bottom_sheet_lists.dart';
import 'bottom_sheet.dart';
import 'comment_list_view.dart';
import 'package:timeago/timeago.dart' as timeago;

class Post extends StatefulWidget {
  const Post({Key? key, required this.postId, required this.postImageUrl})
      : super(key: key);

  final String postId;
  final String postImageUrl;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  String caption = '';
  String postAuthorName = '';
  String postAuthorPfp = '';
  String postTimeFormatted = '';
  List<Comment> comments = [];
  bool _loadingComments = true;
  bool isLiked = false;
  String noOfLikes = '';
  String postAuthorId = '';
  final currentUser = Auth().currentUser!;
  late Stream<DocumentSnapshot> postStream;

  @override
  void initState() {
    super.initState();
    fetchPostData();
    checkInitialLikeState();
    postStream = Auth().db.collection('posts').doc(widget.postId).snapshots();
    postStream.listen(
      (DocumentSnapshot postSnapshot) {
        getNoOfLikes();
        fetchComments();
      },
    );
  }

  Future<void> fetchPostData() async {
    final postDocSnapshot =
        await Auth().db.collection('posts').doc(widget.postId).get();
    caption = postDocSnapshot.data()!['caption'];
    postAuthorName = postDocSnapshot.data()!['authorName'];
    postAuthorPfp = postDocSnapshot.data()!['authorPfp'];
    postAuthorId = postDocSnapshot.data()!['authorID'];
    final timestamp = postDocSnapshot.data()!['timestamp'];
    postTimeFormatted = getFormattedTime(timestamp);
  }

  void getNoOfLikes() async {
    final likes = (await Auth().db.collection('posts').doc(widget.postId).get())
        .data()!['likes']
        .length
        .toString();
    setState(() {
      noOfLikes = likes;
    });
  }

  void checkInitialLikeState() async {
    final postDocSnapshot =
        await Auth().db.collection('posts').doc(widget.postId).get();
    final likes = postDocSnapshot.data()?['likes'] as List<dynamic>;
    setState(() {
      isLiked = likes.contains(currentUser.email);
    });
  }

  void toggleLike() async {
    setState(() {
      isLiked = !isLiked;
    });

    final postDocRef = Auth().db.collection('posts').doc(widget.postId);

    if (isLiked) {
      await postDocRef.update(
        {
          'likes': FieldValue.arrayUnion([currentUser.email])
        },
      );
    } else {
      postDocRef.update(
        {
          'likes': FieldValue.arrayRemove([currentUser.email])
        },
      );
    }
  }

  String getFormattedTime(Timestamp timestamp) {
    final postTime = timestamp.toDate();
    final now = DateTime.now();

    final difference = now.difference(postTime);
    if (difference.inSeconds < 60) {
      return 'Now';
    } else {
      return '${timeago.format(postTime, locale: 'en_short')} ago';
    }
  }

  Future<void> submitComment(String comment) async {
    final postDocRef = Auth().db.collection('posts').doc(widget.postId);
    final userData =
        (await Auth().db.collection('users').doc(Auth().currentUser?.uid).get())
            .data();
    final commentData = {
      'authorId': currentUser.uid,
      'authorName': userData?['name'],
      'authorPicture': userData?['pfp'],
      'comment': comment,
      'timestamp': Timestamp.now(),
    };

    await postDocRef.update(
      {
        'comments': FieldValue.arrayUnion([commentData]),
      },
    );
    fetchComments();
  }

  Future<void> fetchComments() async {
    final postDocRef = Auth().db.collection('posts').doc(widget.postId);
    try {
      final postSnapshot = await postDocRef.get();

      if (postSnapshot.exists) {
        final commentsData = postSnapshot['comments'] as List<dynamic>;

        setState(
          () {
            comments = commentsData.map(
              (commentData) {
                return Comment(
                    authorName: commentData['authorName'],
                    comment: commentData['comment'],
                    authorPicture: commentData['authorPicture']);
              },
            ).toList();
            _loadingComments = false;
          },
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There was an error fetching comments.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          bottomSheet: CustomTextInput(
              hintText: 'Type your comment here...',
              onSubmitted: submitComment),
          resizeToAvoidBottomInset: true,
          body: ListView(
            children: [
              Container(
                height: 15,
                color: const Color.fromRGBO(245, 245, 245, 1),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0.h),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MyProfileScreen(userId: postAuthorId),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        NetworkImage(postAuthorPfp),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          postAuthorName,
                                          style: kHeading.copyWith(
                                              fontSize: 15.sp),
                                        ),
                                        Text(
                                          postTimeFormatted,
                                          style: kSubheading.copyWith(
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.black,
                              size: 25.r,
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                showDragHandle: true,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.r)),
                                ),
                                context: context,
                                builder: (context) {
                                  return BotSheet(
                                    bottomBarList: homePageBottomBarList,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0.h),
                              child: Text(
                                caption,
                                style: kBasicText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0.r),
                              child: Image(
                                fit: BoxFit.cover,
                                height: 175.h,
                                image: NetworkImage(widget.postImageUrl),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0.h),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 40.0.w),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: toggleLike,
                                            child: Icon(
                                              isLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isLiked
                                                  ? primaryColor
                                                  : Colors.grey,
                                              size: 20.r,
                                            ),
                                          ),
                                          Text(
                                            noOfLikes,
                                            style: TextStyle(
                                              color: isLiked
                                                  ? primaryColor
                                                  : Colors.grey,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          child: Icon(
                                            Icons.mode_comment_outlined,
                                            color: const Color.fromRGBO(
                                                189, 189, 189, 1),
                                            size: 20.r,
                                          ),
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         CommentSection(),
                                            //   ),
                                            // );
                                          },
                                        ),
                                        Text(
                                          comments.length.toString(),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: const Color.fromRGBO(
                                                189, 189, 189, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.send,
                            size: 20.r,
                            color: const Color.fromRGBO(189, 189, 189, 1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (comments.isEmpty && _loadingComments)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 150.0.h),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                ),

              // Comments section
              if (comments.isEmpty && !_loadingComments)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 150.0.h),
                  child: const Column(
                    children: [Text('Be the first one to comment!')],
                  ),
                ),
              if (comments.isNotEmpty) CommentListView(comments: comments),
              if (comments.isNotEmpty)
                SizedBox(
                  height: 50.h,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
