// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/material.dart';

class HomeChatsDisplay extends StatelessWidget {
  HomeChatsDisplay({super.key});

  final List<chatItem> chats = [
    chatItem(
        userImage: "assets/images/man1.jpg",
        userName: "Danilo",
        lastMessage: "I sent you home the last time",
        time: 8),
    chatItem(
        userImage: "assets/images/man2.jpg",
        userName: "Aloips",
        lastMessage: "I got a new job",
        time: 2),
    chatItem(
        userImage: "assets/images/man3.jpg",
        userName: "Sami",
        lastMessage: "I will be expecting you soon",
        time: 18),
    chatItem(
        userImage: "assets/images/man4.jpg",
        userName: "Evao",
        lastMessage: "I have received your mesages",
        time: 18),
    chatItem(
        userImage: "assets/images/man3.jpg",
        userName: "Dolapo",
        lastMessage: "Grace married Peter yesterday",
        time: 27),
    chatItem(
        userImage: "assets/images/man1.jpg",
        userName: "Milop",
        lastMessage: "Meet me at Ibadan by 2pm",
        time: 24),
    chatItem(
        userImage: "assets/images/woman2.jpg",
        userName: "Ella",
        lastMessage: "I left the USA",
        time: 48),
    chatItem(
        userImage: "assets/images/woman1.jpg",
        userName: "Sarah",
        lastMessage: "I sent you money",
        time: 4),
  ];

  @override
  Widget build(BuildContext context) {
    chats.sort((a, b) => a.time.compareTo(b.time));

    return Container(
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          // final entry = chats[index];
          return ListTile(
            title: chats[index],
          );
        },
      ),
    );
  }
}

class chatItem extends StatelessWidget {
  final String userImage;
  final String userName;
  final String lastMessage;
  final int time;

  const chatItem({
    super.key,
    required this.userImage,
    required this.userName,
    required this.lastMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(userImage),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(fontSize: 13),
                      ), //this is the username
                      Text(
                        lastMessage,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ) //This is insight into recent message
                    ],
                  ),
                ),
              ),
              Text('$time' 'mins', style: TextStyle(fontSize: 13))
            ],
          )
        ],
      ),
    );
  }
}
