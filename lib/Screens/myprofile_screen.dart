import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Authentication/auth.dart';
import 'package:frendify/widgets/post.dart';
import '../constants.dart';
import '../widgets/button.dart';
import '../widgets/profile_info.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final currentUser = Auth().currentUser!;
  bool isFollowed = false;

  bool isCurrentUser = false;
  String userName = '';
  String name = '';
  List following = [];
  List followers = [];
  String pfp = '';

  Future<List<DocumentSnapshot>> getUserPosts(String userId) async {
    final QuerySnapshot snapshot = await Auth()
        .db
        .collection('posts')
        .where('authorID',
            isEqualTo: userId) // Query posts for the specified user
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs;
  }

  Future<void> getUserData() async {
    try {
      final currentUser = Auth().currentUser;
      if (currentUser == null) {
        return;
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      setState(() {
        isCurrentUser = currentUser.uid == widget.userId;
        userName = userDoc['username'];
        name = userDoc['name'];
        following = userDoc['following'] as List<dynamic>;
        followers = userDoc['followers'] as List<dynamic>;
        pfp = userDoc['pfp'].toString();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Center(child: Text('There was an error loading the profile')),
        ),
      );
    }
  }

  void checkInitialFollowState() async {
    final postDocSnapshot =
        await Auth().db.collection('users').doc(widget.userId).get();
    final followers = postDocSnapshot.data()?['followers'] as List<dynamic>;
    setState(() {
      isFollowed = followers.contains(currentUser.email);
    });
  }

  void toggleFollow() async {
    setState(() {
      isFollowed = !isFollowed;
    });

    final postDocRef = Auth().db.collection('users').doc(widget.userId);

    if (isFollowed) {
      await postDocRef.update(
        {
          'followers': FieldValue.arrayUnion([currentUser.email])
        },
      );
    } else {
      postDocRef.update(
        {
          'followers': FieldValue.arrayRemove([currentUser.email])
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    checkInitialFollowState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(name),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: Column(
          children: [
            ProfileInfo(
                username: userName,
                following: '0',
                followers: followers,
                pfp: pfp,
                isCurrentUser: isCurrentUser,
                userId: widget.userId,
                updateUserData: getUserData),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              child: isCurrentUser
                  ? null
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyButton(
                          buttonText: isFollowed ? 'Unfollow' : 'Follow',
                          buttonColor: primaryColor,
                          buttonWidth: 110.w,
                          buttonHeight: 30.h,
                          onTap: toggleFollow,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        MyButton(
                            buttonText: 'Message',
                            buttonColor: Colors.white,
                            borderColor: primaryColor,
                            textColor: primaryColor,
                            buttonWidth: 110.w,
                            buttonHeight: 30.h),
                      ],
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
              child: SizedBox(
                height: 50,
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  bottom: TabBar(
                    indicatorColor: primaryColor,
                    unselectedLabelColor: const Color(0xffbdbdbd),
                    labelColor: primaryColor,
                    tabs: [
                      Tab(
                        icon: Icon(
                          Icons.grid_view,
                          size: 20.r,
                        ),
                      ),
                      // Tab(
                      //   icon: Icon(
                      //     Icons.view_headline_sharp,
                      //     size: 20.r,
                      //   ),
                      // ),
                      Tab(
                        icon: Icon(
                          Icons.bookmark_border,
                          size: 20.r,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: TabBarView(
                  children: [
                    FutureBuilder<List<DocumentSnapshot>>(
                      future: getUserPosts(widget.userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // While waiting for data, you can show a loading indicator
                          return Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          // Show an error message if something went wrong
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'There was a problem loading the posts!'),
                            ),
                          );
                          // return Text(
                          //     'Error loading posts: ${snapshot.error}');
                        } else {
                          // If the data is available, display the posts
                          final posts = snapshot.data;
                          if (posts!.isNotEmpty) {
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                childAspectRatio: 1.5,
                              ),
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                final imageUrl = posts[index]['imageUrl'];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Post(
                                          postId: posts[index].id,
                                          postImageUrl: imageUrl,
                                          // postLikes: postLikes,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0.r),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: primaryColor,
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                        return const Center(
                          child: Text(
                            'There are currently no posts.',
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
                    const SingleChildScrollView(
                      child: Column(
                        children: [
                          // Post(),
                          // Post(),
                          // Post(),
                        ],
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 1.5,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0.r),
                          child: const Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/profile.jpeg'),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0.r),
                          child: const Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/img_1.png'),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0.r),
                          child: const Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/img_1.png'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
