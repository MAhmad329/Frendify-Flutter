import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Screens/notification_screen.dart';
import 'package:frendify/Screens/myprofile_screen.dart';
import '../Authentication/auth.dart';
import '../constants.dart';
import '../widgets/post.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Future<List<Post>> fetchPosts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await Auth()
        .db
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .get();

    List<Post> posts = querySnapshot.docs.map((doc) {
      return Post(
        postId: doc.id,
        postImageUrl: doc.data()['imageUrl'],
        detailed: false,
      );
    }).toList();

    return posts;
  }

  double postItemHeight(BuildContext context) {
    // Calculate the post item height based on the screen size
    double screenHeight = MediaQuery.of(context).size.height;
    double postHeight = screenHeight * 0.47; // Adjust this value as needed
    return postHeight;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyProfileScreen(
                    userId: Auth().currentUser!.uid,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.person_outline,
              color: Colors.black,
              size: 25.r,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.0.w),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                  size: 25.r,
                ),
              ),
            ),
          ],
          title: Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: TabBar(
              unselectedLabelStyle: TextStyle(fontSize: 14.sp),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 1.5.w, color: primaryColor),
                insets: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
              ),
              indicatorWeight: 2.w,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey,
              splashFactory: NoSplash.splashFactory,
              labelStyle: TextStyle(fontSize: 14.sp),
              labelPadding: EdgeInsets.only(bottom: 4.h),
              padding: EdgeInsets.only(bottom: 10.h),
              tabs: const [
                Tab(text: 'Featured'),
                Tab(text: 'Following'),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: false,
          child: TabBarView(
            children: [
              FutureBuilder<List<Post>>(
                future: fetchPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      // Wrap the CircularProgressIndicator with Center
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error loading posts');
                  } else {
                    List<Post> posts = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: postItemHeight(context),
                          child: Post(
                            postId: posts[index].postId,
                            postImageUrl: posts[index].postImageUrl,
                            detailed: false,
                            // Pass any other required data
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              // SingleChildScrollView(
              //   physics: AlwaysScrollableScrollPhysics(),
              //   child: Column(
              //     children: [
              //       Post(),
              //       Post(),
              //       Post(),
              //       Post(),
              //     ],
              //   ),
              // ),
              // SingleChildScrollView(
              //   physics: AlwaysScrollableScrollPhysics(),
              //   child: Column(
              //     children: [
              //       Post(),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
