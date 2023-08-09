// import 'comments_model.dart';
// import 'package:flutter/material.dart';
//
// class CommentTextField extends StatefulWidget {
//   @override
//   _CommentTextFieldState createState() => _CommentTextFieldState();
// }
//
// class _CommentTextFieldState extends State<CommentTextField> {
//   TextEditingController _commentController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: _commentController,
//             decoration: InputDecoration(
//               hintText: 'Write a comment...',
//             ),
//           ),
//         ),
//         IconButton(
//           icon: Icon(Icons.send),
//           onPressed: () {
//             // Add the comment to the dummyComments list
//             final newComment =
//                 Comment(author: 'You', comment: _commentController.text);
//             dummyComments.add(newComment);
//             // Clear the comment text field
//             _commentController.clear();
//             // Force the UI to update
//             setState(() {});
//           },
//         ),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _commentController.dispose();
//     super.dispose();
//   }
// }
