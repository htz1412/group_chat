import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat/message_text_field.dart';
import 'package:flutter_chat/widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  // final instance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  // final messagesCollectionPath = '/chats/1EGiS7Yt5wFWHycO04oL/messages';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  auth.signOut();
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4),
                child: Messages(),
              ),
            ),
            MessageTextField(),
          ],
        ),
      ),
    );
  }
}
