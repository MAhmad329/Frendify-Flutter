import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Authentication/auth.dart';
import 'package:frendify/Screens/followers_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../constants.dart';
import 'dart:io';

import 'mbs_addition_options.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({
    required this.username,
    required this.pfp,
    required this.isCurrentUser,
    required this.userId,
    required this.updateUserData,
    super.key,
  });
  final String username;
  final String pfp;
  final bool isCurrentUser;
  final String userId;
  final Function updateUserData;

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  List<dynamic> followers = [];
  List<dynamic> followings = [];
  String noOfFollowers = '';
  String noOfFollowing = '';
  bool isLoading = false;
  late Stream<DocumentSnapshot> postStream;

  Future<void> uploadImage(source) async {
    XFile? file =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    String uid = Auth().currentUser!.uid;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('pfp/$uid');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    setState(() => isLoading = true);
    if (widget.pfp.isNotEmpty) {
      try {
        await FirebaseStorage.instance.refFromURL(widget.pfp).delete();
      } catch (e) {
        print('Failed to delete old profile picture: $e');
      }
    }

    try {
      await referenceImageToUpload.putFile(File(file.path));
      final imageUrl = await referenceImageToUpload.getDownloadURL();
      await Auth().db.collection('users').doc(uid).update({'pfp': imageUrl});
      widget.updateUserData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload profile picture: $e'),
          ),
        );
      }
    }
    setState(() => isLoading = false);
  }

  void getNoOfFollowersAndFollowing() async {
    followers = (await Auth().db.collection('users').doc(widget.userId).get())
        .data()!['followers'] as List<dynamic>;
    followings = (await Auth().db.collection('users').doc(widget.userId).get())
        .data()!['following'] as List<dynamic>;

    final followerNo = followers.length.toString();
    final followingNo = followings.length.toString();
    setState(() {
      noOfFollowers = followerNo;
      noOfFollowing = followingNo;
    });
  }

  @override
  void initState() {
    super.initState();
    postStream = Auth().db.collection('users').doc(widget.userId).snapshots();
    postStream.listen(
      (DocumentSnapshot postSnapshot) {
        widget.updateUserData;
        getNoOfFollowersAndFollowing();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      child: Column(
        children: [
          SizedBox(
            height: 33.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: widget.isCurrentUser
                        ? () {
                            showModalBottomSheet(
                              showDragHandle: true,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.r),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return additionalOptions(
                                  onPressFunc1: () async {
                                    Navigator.pop(context);
                                    await uploadImage(ImageSource.camera);
                                  },
                                  onPressFunc2: () async {
                                    Navigator.pop(context);
                                    await uploadImage(ImageSource.gallery);
                                  },
                                );
                              },
                            );
                          }
                        : () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return Container(
                                  color: Colors.black,
                                  child: InteractiveViewer(
                                    child: Image.network(
                                      widget.pfp,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                    child: Stack(
                      children: [
                        // Display the image or placeholder
                        if (widget.pfp.isNotEmpty && !isLoading)
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(widget.pfp),
                            radius: 60.r,
                          )
                        else
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.pfp),
                            backgroundColor: Colors.black, // Placeholder color
                            radius: 60.r,
                          ),

                        if (isLoading)
                          Positioned.fill(
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '@${widget.username}',
                    style: kText1.copyWith(
                        fontSize: 18.sp, color: const Color(0xffACACAC)),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FollowersScreen(
                        follows: followers,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Text(
                      noOfFollowers,
                      style: kText1.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      'Followers',
                      style: kHeading.copyWith(
                        color: const Color(0xffBDBDBD),
                        fontSize: 15.sp,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FollowersScreen(
                        follows: followings,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Text(
                      noOfFollowing,
                      style: kText1.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      'Following',
                      style: kHeading.copyWith(
                        fontSize: 15.sp,
                        color: const Color(0xffBDBDBD),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
