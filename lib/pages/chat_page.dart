import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void sendMessage(String message) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference messagesCollection = firestore.collection('messages');
    try {
      await messagesCollection.add({
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('Message sent successfully.');
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Stream<QuerySnapshot<Object?>> getMessagesStream() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference messagesCollection = firestore.collection('messages');
    return messagesCollection
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chat'),
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

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error loading messages');
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
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
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  child: Icon(Icons.send),
                  elevation: 1.0,
                  shape: CircleBorder(),
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
