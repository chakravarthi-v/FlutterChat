import 'dart:io';

import 'package:chat/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth=FirebaseAuth.instance;
  var isLoading=false;
  void _submitAuthForm(String email,String password,
      String username,File image,
      bool isLogin,BuildContext ctx) async {
    AuthResult authResult;
    try {
      setState(() {
        isLoading=true;
      });
      if (isLogin) {
        authResult =
        await auth.signInWithEmailAndPassword(email: email, password: password);
      }
      else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      final ref=FirebaseStorage.instance.ref()
          .child('user_image').child(authResult.user.uid+'.jpg');
      await ref.putFile(image).onComplete;
      final url=await ref.getDownloadURL();

      await Firestore.instance.collection('users').document(authResult.user.uid)
      .setData({
        'username':username,
        'email':email,
        'Image_url':url,
      });
    } on PlatformException catch(error){
      var message='An error occurred, please check your credentials';
      if(error.message!=null){
        message=error.message;
      }
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,));
      setState(() {
        isLoading=true;
      });
    }
    catch(error){
      print(error);
      setState(() {
        isLoading=true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm,isLoading),
    );
  }
}
