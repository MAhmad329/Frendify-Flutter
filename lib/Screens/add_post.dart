import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Authentication/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frendify/widgets/button.dart';
import 'package:frendify/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/post_options.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key, required this.picture}) : super(key: key);

  final XFile? picture;

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool isLoading = false;
  TextEditingController captionController = TextEditingController();

  void _savePostData() async {
    setState(() => isLoading = true);
    if (widget.picture == null) {
      return;
    }
    try {
      final currentUser = Auth().currentUser;
      if (currentUser == null) {
        return;
      }
      if (widget.picture == null) return;
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      String uid = currentUser.uid;
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('posts/$uid');
      Reference referenceImageToUpload =
          referenceDirImages.child(uniqueFileName);
      await referenceImageToUpload.putFile(File(widget.picture!.path));
      final imageUrl = await referenceImageToUpload.getDownloadURL();
      final Timestamp timestamp = Timestamp.now();
      final authorData =
          (await Auth().db.collection('users').doc(currentUser.uid).get())
              .data();

      Map<String, dynamic> postData = {
        'authorID': uid,
        'authorPfp': authorData?['pfp'],
        'authorName': authorData?['name'],
        'imageUrl': imageUrl,
        'caption': captionController.text.trim(),
        'timestamp': timestamp,
        'likes': [],
        'comments': [],
      };

      await Auth().db.collection('posts').add(postData);
      setState(
        () {
          isLoading = false;
        },
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Post Uploaded!'),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('There was an error uploading the post:')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ModalProgressHUD(
      color: primaryColor,
      inAsyncCall: isLoading,
      progressIndicator: CircularProgressIndicator(
        color: primaryColor,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Post'),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0.r),
                          child: Image(
                            fit: BoxFit.cover,
                            height: 200.h,
                            image: XFileImage(widget.picture!),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextField(
                      controller: captionController,
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: null,
                      decoration: kPostTextFieldDecoration),
                  SizedBox(
                    height: 10.h,
                  ),
                  const PostOptions(
                    "Add Location",
                    Icons.location_on_outlined,
                    Icons.arrow_forward_ios,
                  ),
                  const PostOptions(
                    "Privacy",
                    Icons.lock_outline,
                    Icons.arrow_forward_ios,
                    secondText: 'Public',
                    moreOptions: true,
                  ),
                ],
              ),
              Flexible(
                child: SizedBox(
                  height: 100.h,
                ),
              ),
              Flexible(
                child: Row(
                  children: [
                    MyButton(
                      buttonText: 'Cancel',
                      buttonColor: Colors.black26,
                      buttonWidth: 160.w,
                      buttonHeight: 50,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Flexible(
                      child: SizedBox(
                        width: 10.w,
                      ),
                    ),
                    MyButton(
                      buttonText: 'Post',
                      buttonColor: primaryColor,
                      buttonWidth: 160.w,
                      buttonHeight: 50,
                      onTap: () {
                        _savePostData();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    ));
  }
}
