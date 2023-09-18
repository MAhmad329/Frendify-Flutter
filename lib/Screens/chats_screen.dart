import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Authentication/auth.dart';
import 'package:frendify/Screens/chatdetails_screen.dart';
import '../Models/chats_model.dart';
import '../Models/messages_model.dart';
import '../widgets/search_bar.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final TextEditingController _searchController = TextEditingController();

  Future<bool> _onWillPop() async {
    Navigator.popAndPushNamed(context, 'home_screen');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                _onWillPop();
              },
            ),
            title: const Text('Chats'),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
                  child: CustomSearchbar(searchController: _searchController),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    final chatDocs = snapshot.data!.docs;

                    return Column(
                      children: chatDocs.map((chatDoc) {
                        final chatData = chatDoc.data() as Map<String, dynamic>;
                        final chatParticipants = chatData['participants'];

                        // Find the other participant's ID
                        final otherParticipantId = chatParticipants
                            .firstWhere((id) => id != Auth().currentUser!.uid);

                        final chatParticipant = Auth()
                            .db
                            .collection('users')
                            .doc(otherParticipantId)
                            .get();

                        final chatMessages =
                            chatData['messages'] as List<dynamic>;
                        final latestMessageData =
                            chatMessages.isNotEmpty ? chatMessages.last : null;

                        return FutureBuilder<DocumentSnapshot>(
                          future: chatParticipant,
                          builder: (context, participantSnapshot) {
                            if (!participantSnapshot.hasData) {
                              return const CircularProgressIndicator();
                            }

                            final participantData = participantSnapshot.data!
                                .data() as Map<String, dynamic>;
                            final participantName = participantData['username'];
                            final participantImageURL = participantData['pfp'];

                            // Create ChatUsers object
                            final chatUser = ChatUsers(
                              name: participantName,
                              imageURL: participantImageURL,
                            );

                            String latestMessageContent = '';

                            if (latestMessageData != null) {
                              final latestMessage =
                                  Message.fromFirestore(latestMessageData);
                              latestMessageContent = latestMessage.content;
                            }

                            return ListTile(
                              title: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatDetailsScreen(
                                          userId: otherParticipantId),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        chatUser.imageURL,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(chatUser.name),
                                        Text(
                                          latestMessageContent,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // You can display other chat information here
                            );
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
