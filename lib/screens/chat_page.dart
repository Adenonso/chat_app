import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/chats/ChatService.dart';
import 'package:chat_app/chats/chat_bubble.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  //text controller
  final TextEditingController _messageController = TextEditingController();

  //create instance for chat and auth service
  final Chatservice _chatservice = Chatservice();
  final AuthService _authService = AuthService();

  //send messages
  void sendMessage() async {
    //return a message only if there is a message inside the textfield
    if (_messageController.text.isNotEmpty) {
      //send message
      await _chatservice.sendMessage(receiverID, _messageController.text);

      //clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          //display all messages, since it covers the
          // most part of the screen, we can set it to
          //expanded
          Expanded(child: _buildMessageList()),

          //user input
          _buildUserInput()
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatservice.getMessages(receiverID, senderID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }

          //return list of messages
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentSUer = data['senderID'] == _authService.getCurrentUser()!.uid;

    //align current user message to the right
    var alignment =
        isCurrentSUer ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentSUer ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data["message"], isCurrentUser: isCurrentSUer),
          ],
        ));
  }

  //build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0, left: 10, right: 10),
      child: Row(
        children: [
          //textfield should take up most of the space
          Expanded(
              child: MyTextfield(
                  hintText: "Type a message",
                  obscureText: false,
                  controller: _messageController)),
          //send button
          Container(
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(left: 10),
              child: IconButton(
                  onPressed: sendMessage,
                  icon: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
