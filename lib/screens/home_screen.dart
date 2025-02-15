import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/chats/ChatService.dart';
import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/widgets/home_chats_display.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Chatservice _chatservice = Chatservice();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: AppBar(
              title: Text(
                'Chats Apps',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              actions: [
                // TextButton(
                //     onPressed: () {
                //       Navigator.pushNamed(context, '/register');
                //     },
                //     child: Text(
                //       'Register',
                //       style: TextStyle(color: Colors.black, fontSize: 15),
                //     )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(25)),
              child: ListTile(
                leading: Icon(Icons.search),
                title: Text('Search'),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                _buildUserList(),
              ],
            ),
          ),
          // Expanded(
          //   child: HomeChatsDisplay(),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          // _showModalBottomSheet(context); // Add your onPressed code here!
        },
        child: Icon(
          Icons.message_outlined,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatservice.getUsersStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text('Error');
          }
          //loading....
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }
          //return the list view
          return Expanded(
            child: ListView(
              children: snapshot.data!
                  .map<Widget>(
                      (UserData) => _buildUserListItem(UserData, context))
                  .toList(),
            ),
          );
        });
  }

  //build individual list tile
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users ecxept the current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          //tapped on a user -> go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: userData["email"],
                        receiverID: userData["uid"],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
