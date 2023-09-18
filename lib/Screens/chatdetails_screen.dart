import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/widgets/chat_bubble.dart';
import 'package:frendify/constants.dart';
import 'package:frendify/widgets/text_input.dart';
import 'package:intl/intl.dart';

import '../Authentication/auth.dart';
import '../Models/messages_model.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({super.key, required this.userId});
  final String userId;
  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  String userName = '';
  String name = '';
  String chatId = '';
  String currentUserId = Auth().currentUser!.uid;

  Future<void> getUserData() async {
    try {
      final userDoc =
          await Auth().db.collection('users').doc(widget.userId).get();

      setState(() {
        userName = userDoc['username'];
        name = userDoc['name'];
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

  String _generateChatId() {
    final List<String> userIds = [widget.userId, Auth().currentUser!.uid]
      ..sort();
    return userIds.join('_');
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    chatId = _generateChatId();
  }

  Future<void> sendMessage(String content) async {
    final message = Message(
      senderId: Auth().currentUser!.uid,
      receiverId: widget.userId,
      content: content,
      timestamp: DateTime.now(),
    );

    final chatRef = Auth().db.collection('chats').doc(chatId);

    final chatDoc = await chatRef.get();

    if (chatDoc.exists) {
      // Chat document already exists, update messages array
      await chatRef.update({
        'messages': FieldValue.arrayUnion([message.toJson()])
      });
    } else {
      // Chat document doesn't exist, create it with the message
      await chatRef.set({
        'participants': [currentUserId, widget.userId],
        'messages': [message.toJson()],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Column(
            children: [
              Text(
                name,
                style: kText1.copyWith(fontSize: 18.sp),
              ),
              Text(
                userName,
                style: kText2.copyWith(
                  fontSize: 10.sp,
                  color: const Color(0xffbdbdbd),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.0.w),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                    stream:
                        Auth().db.collection('chats').doc(chatId).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const Center(
                          child: Text('Message to start a chat!'),
                        );
                      }

                      final chatData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final messagesData =
                          chatData['messages'] as List<dynamic>;
                      final messages = messagesData.map(
                        (messageData) {
                          return Message.fromFirestore(messageData);
                        },
                      ).toList();

                      return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isCurrentUser =
                              message.senderId == currentUserId;
                          final messageTime = message.timestamp;
                          final isDifferentDay = index == 0 ||
                              !isSameDay(
                                  messages[index - 1].timestamp, messageTime);

                          Widget dateHeader = const SizedBox.shrink();
                          if (isDifferentDay) {
                            final formattedDate =
                                DateFormat('MMMM dd, yyyy').format(messageTime);
                            dateHeader = Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: isCurrentUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              dateHeader,
                              ChatBubble(
                                text: message.content,
                                isCurrentUser: isCurrentUser,
                                time: messageTime,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                CustomTextInput(
                  hintText: 'Type your message here...',
                  onSubmitted: (value) {
                    sendMessage(value);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
