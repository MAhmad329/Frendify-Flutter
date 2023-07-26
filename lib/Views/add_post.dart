import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frendify/widgets/button.dart';
import 'package:frendify/constants.dart';

import '../widgets/post_options.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key? key, required this.picture}) : super(key: key);

  final XFile? picture;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
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
                          image: XFileImage(picture!),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextField(
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
                  "Where to post",
                  Icons.lock_outline,
                  Icons.arrow_forward_ios,
                  secondText: 'Everyone',
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
                    buttonText: 'Draft',
                    buttonColor: Colors.black26,
                    buttonWidth: 160.w,
                    buttonHeight: 50,
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
                  ),
                ],
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    ));
  }
}
