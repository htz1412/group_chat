import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {
  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  String _enteredMessage = '';
  final _messageController = TextEditingController();
  final _userId = FirebaseAuth.instance.currentUser.uid;

  void _sendMessage() async {
    _messageController.clear();

    final userData =
        await FirebaseFirestore.instance.collection('users').doc(_userId).get();

    setState(() {});
    await FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        'userId': _userId,
        'userName': userData['userName'],
        'imageUrl': userData['image_url'],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.newline,
              controller: _messageController,
              cursorHeight: 20,
              minLines: 1,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: Colors.grey),
                isCollapsed: true,
                border: InputBorder.none,
              ),
              onChanged: (message) {
                setState(() {
                  _enteredMessage = message;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send_rounded,
            ),
            splashColor: Colors.blue,
            splashRadius: 22,
            onPressed:
                _messageController.text.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
