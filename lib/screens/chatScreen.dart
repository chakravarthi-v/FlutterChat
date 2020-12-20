import 'package:chat/chat/messages.dart';
import 'package:chat/chat/newMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    final fbm=FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (message) {
      print(message);
      return;
    },
    onLaunch: (message) {
      print(message);
      return;
    },
    onResume: (message) {
      print(message);
      return;
    },);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('chat'),actions: <Widget>[
        DropdownButton(underline: Container(),
          icon: Icon(Icons.more_vert,
          color: Theme.of(context).primaryIconTheme.color,),
          items: [
            DropdownMenuItem(child: Container(child: Row(
              children: <Widget>[
                Icon(Icons.exit_to_app),
                SizedBox(width: 8,),
                Text('Logout'),
              ],
            ),),
              value: 'logout',)],
          onChanged: (value) {
            if(value=='logout'){
              FirebaseAuth.instance.signOut();
            }
          },
        ),
      ],),
      body: Container(child: Column(children: <Widget>[
        Expanded(child: Messages()),
        NewMessage(),
      ],),
      ),
    );
  }
}
