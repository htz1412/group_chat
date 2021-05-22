import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final instance = FirebaseFirestore.instance;
    final userId = FirebaseAuth.instance.currentUser.uid;

    return StreamBuilder(
      stream: instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) {
            return MessageBubble(
              chatDocs[index]['userName'],
              chatDocs[index]['imageUrl'],
              chatDocs[index]['text'],
              chatDocs[index]['userId'] == userId,
            );
          },
        );
      },
    );
  }
}
