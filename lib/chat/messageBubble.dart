import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message,this.userName,this.imageUrl,this.isMe,{this.key});
  final String message;
  final String userName;
  final String imageUrl;
  final bool isMe;
  final Key key;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color:isMe?Colors.grey[300]:Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:!isMe?Radius.circular(0):Radius.circular(12),
                    bottomRight: isMe?Radius.circular(0):Radius.circular(12),
                  )),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 14,horizontal: 16),
              child: Column(crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
                children: [
                Text(userName,style:TextStyle(fontWeight:FontWeight.bold,
                    color:isMe?Colors.black:Theme.of(context).accentTextTheme.title.color),),
                Text(message,textAlign: isMe?TextAlign.end:TextAlign.start,
                  style: TextStyle(
                  color:isMe?Colors.black:Theme.of(context).accentTextTheme.title.color),),],)
            ),
          ],
        ),
        Positioned(
          top: -10,
          left: isMe?null:120,
          right: isMe?120:null,
          child: CircleAvatar(backgroundImage: imageUrl==null?null:NetworkImage(imageUrl),),),
      ],
    overflow: Overflow.visible,
    ); 
  }
}
