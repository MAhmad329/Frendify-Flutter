import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Screens/myprofile_screen.dart';
import 'package:frendify/constants.dart';
import 'package:frendify/Models/comments_model.dart';
import 'package:frendify/widgets/text_input.dart';
import '../Authentication/auth.dart';
import 'bottom_sheet.dart';
import 'comment_list_view.dart';
import 'package:timeago/timeago.dart' as timeago;

class Post extends StatefulWidget {
  const Post(
      {Key? key,
      required this.postId,
      required this.postImageUrl,
      required this.detailed})
      : super(key: key);

  final String postId;
  final String postImageUrl;
  final bool detailed;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool deleting = false;
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
  late DocumentReference postDocRef;

  @override
  void initState() {
    super.initState();
    fetchPostData();
    checkInitialLikeState();
    postDocRef = Auth().db.collection('posts').doc(widget.postId);
    postStream = postDocRef.snapshots();
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
    postAuthorId = postDocSnapshot.data()!['authorID'];
    final timestamp = postDocSnapshot.data()!['timestamp'];
    postTimeFormatted = getFormattedTime(timestamp);

    final userDocSnapshot =
        await Auth().db.collection('users').doc(postAuthorId).get();
    postAuthorPfp = userDocSnapshot.data()!['pfp'];
    postAuthorName = userDocSnapshot.data()!['name'];
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
    final commentData = {
      'authorId': currentUser.uid,
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
    try {
      final postSnapshot = await postDocRef.get();

      if (postSnapshot.exists) {
        final commentsData = postSnapshot['comments'] as List<dynamic>;

        // Fetch user data for comments
        final commentsWithUserData =
            await Future.wait(commentsData.map((commentData) async {
          final author = await Auth()
              .db
              .collection('users')
              .doc(commentData['authorId'])
              .get();
          final userData = author.data();

          return Comment(
            comment: commentData['comment'],
            authorName: userData?['name'],
            authorId: commentData['authorId'],
            authorPicture: userData?['pfp'],
          );
        }));

        setState(
          () {
            comments = commentsWithUserData;
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

  Future<void> deletePost() async {
    if (deleting) return; // Avoid multiple delete attempts

    setState(() {
      deleting = true;
    });

    try {
      await postDocRef.delete();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text('There Was An Error Deleting the Post!'),
          ),
        ),
      );
    } finally {
      setState(() {
        deleting = false;
      });
    }
  }

  double itemHeight(BuildContext context) {
    // Calculate the post item height based on the screen size
    double screenHeight = MediaQuery.of(context).size.height;
    double itemHeight = screenHeight * 0.2; // Adjust this value as needed
    return itemHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: widget.detailed
              ? AppBar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  title: const Text('Post'),
                  centerTitle: true,
                )
              : null,
          bottomSheet: widget.detailed
              ? CustomTextInput(
                  hintText: 'Type your comment here...',
                  onSubmitted: submitComment)
              : null,
          resizeToAvoidBottomInset: true,
          body: ListView(
            physics: widget.detailed
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
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
                                    backgroundColor: Colors.black,
                                    backgroundImage: postAuthorPfp.isNotEmpty
                                        ? NetworkImage(postAuthorPfp)
                                        : const NetworkImage(
                                            'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg'),
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
                                    bottomBarList: [
                                      if (postAuthorId == currentUser.uid)
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: InkWell(
                                            onTap: () {
                                              deletePost();
                                              Navigator.pop(context);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Delete Post',
                                                  style: kHeading.copyWith(
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
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
                            child: GestureDetector(
                              onTap: () {
                                // Show the full-sized image in a dialog
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return Container(
                                      color: Colors.black,
                                      child: InteractiveViewer(
                                        child: Image.network(
                                          widget.postImageUrl,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  widget.postImageUrl,
                                  fit: BoxFit.cover,
                                  height: 175.0.h,
                                ),
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
              if (widget.detailed && comments.isEmpty && _loadingComments)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 150.0.h),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                ),

              // Comments section
              if (widget.detailed && comments.isEmpty && !_loadingComments)
                const Column(
                  children: [Text('Be the first one to comment!')],
                ),
              if (widget.detailed && comments.isNotEmpty)
                CommentListView(comments: comments),
              if (widget.detailed && comments.isNotEmpty)
                SizedBox(
                  height: 60.h,
                ),
              if (deleting)
                Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
