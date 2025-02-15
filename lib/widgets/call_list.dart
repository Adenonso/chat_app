import 'package:flutter/material.dart';

class CallList extends StatelessWidget {
  CallList({super.key});

  final List<Call_Item> chats = [
    Call_Item(userImage: "assets/images/man1.jpg", userName: "Danilo", time: 8),
    Call_Item(userImage: "assets/images/man2.jpg", userName: "Aloips", time: 2),
    Call_Item(userImage: "assets/images/man3.jpg", userName: "Sami", time: 18),
    Call_Item(userImage: "assets/images/man4.jpg", userName: "Evao", time: 18),
  ];

  @override
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

class Call_Item extends StatelessWidget {
  final String userImage;
  final String userName;
  final int time;

  const Call_Item({
    super.key,
    required this.userImage,
    required this.userName,
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
                radius: 25,
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
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ), //this is the username
                      Text('$time' 'mins', style: TextStyle(fontSize: 13))
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.call,
                size: 25,
              )
            ],
          )
        ],
      ),
    );
  }
}
