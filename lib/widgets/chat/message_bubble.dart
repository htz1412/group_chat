import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.userName, this.imageUrl, this.message, this.isMe);

  final String userName;
  final String message;
  final bool isMe;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isMe
            ? Row(
                children: [
                  messageContainer(context),
                  SizedBox(width: 6),
                  profileAvatar(),
                ],
              )
            : Row(
                children: [
                  profileAvatar(),
                  SizedBox(width: 6),
                  messageContainer(context),
                ],
              ),
      ],
    );
  }

  Widget profileAvatar() {
    return CircleAvatar(
      backgroundColor: Colors.grey[200],
      backgroundImage: NetworkImage(imageUrl),
    );
  }

  Widget messageContainer(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isMe ? Theme.of(context).accentColor : Colors.grey[300],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      margin: const EdgeInsets.symmetric(vertical: 1.5),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: TextStyle(
              color: isMe
                  ? Theme.of(context)
                      .accentTextTheme
                      .headline6
                      .color
                      .withOpacity(0.7)
                  : Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2),
          Text(
            message,
            style: TextStyle(
              color: isMe
                  ? Theme.of(context).accentTextTheme.headline6.color
                  : Colors.black,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
