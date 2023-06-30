import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late String _userId; // User ID variable

  @override
  void initState() {
    super.initState();
    retrieveUserId(); // Retrieve the user ID when the widget is initialized
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> retrieveUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid; // Store the user ID in the state variable
      });
    }
  }

  void sendMessage(String message) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference messagesCollection = firestore.collection('messages');
    try {
      await messagesCollection.add({
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': _userId, // Use the user ID from the state variable
      });

      print('Message sent successfully.');
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Stream<QuerySnapshot<Object?>> getMessagesStream() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference messagesCollection = firestore.collection('messages');
    return messagesCollection // Use the user ID from the state variable
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  bool isSameDate(DateTime? date1, DateTime? date2) {
    return date1?.year == date2?.year &&
        date1?.month == date2?.month &&
        date1?.day == date2?.day;
  }

  String formattedDate(DateTime? date) {
    final now = DateTime.now();
    if (isSameDate(date, now)) {
      return 'Today';
    } else if (isSameDate(date, now.subtract(Duration(days: 1)))) {
      return 'Yesterday';
    } else {
      return DateFormat.yMMMd().format(date!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chat'),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getMessagesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data?.docs;
                  return ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messages?.length,
                    itemBuilder: (context, index) {
                      final message = messages?[index]['message'];
                      final timestamp = messages?[index].get('timestamp');
                      final formattedTime = timestamp != null
                          ? DateFormat.Hm().format(timestamp.toDate())
                          : '';
                      final userId = messages?[index].get('userId');

                      // Check if the message is from the current user
                      final isCurrentUser = userId == _userId;

                      // Check if the message is the first message or
                      // the date of the current message is different from the previous one
                      final bool showDateDivider = index == 0 ||
                          !isSameDate(
                              messages?[index - 1].get('timestamp')?.toDate(),
                              timestamp?.toDate());

                      return Column(
                        children: [
                          if (showDateDivider)
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                formattedDate(timestamp?.toDate()),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: isCurrentUser
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: isCurrentUser
                                        ? const Color.fromARGB(255, 104, 20, 48)
                                        : const Color.fromARGB(
                                            255, 215, 103, 140),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: isCurrentUser
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        formattedTime,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error loading messages');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Write a message...',
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    String message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      sendMessage(message);
                      _messageController.clear();
                      // Scroll to the bottom when a new message is sent
                      _scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  child: const Icon(Icons.send),
                  elevation: 1.0,
                  shape: const CircleBorder(),
                  mini: true,
                  backgroundColor: Colors.pink,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
