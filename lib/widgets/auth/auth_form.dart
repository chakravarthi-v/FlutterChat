import 'dart:io';

import 'package:chat/pickers/userImagepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email,String password,
      String username,File image
      ,bool isLogin, BuildContext ctx) submitFn;
  final bool isLoading;
  AuthForm(this.submitFn,this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey=GlobalKey<FormState>();
  var _isLogin=true;
  String _userEmail='';
  String _userName='';
  String _userPassword='';
  File _userImageFile;
  void _pickImage(File image){
    _userImageFile=image;
  }
  void trySubmit(){
    final isValid=_formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(_userImageFile==null && !_isLogin){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an Image'),
      backgroundColor: Theme.of(context).errorColor,));
      return;
    }
    if(isValid){
      _formKey.currentState.save();
      widget.submitFn(
          _userEmail.trim(),
          _userPassword.trim(),
          _userName.trim(),
          _userImageFile,
          _isLogin,
          context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(child:
      Card(margin: EdgeInsets.all(20),
        child:SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if(!_isLogin)UserImagePicker(_pickImage),
                TextFormField(
                  key: ValueKey('E-mail'),
                  validator:(value) {
                    if(value.isEmpty|| !value.contains('@')){
                      return 'Please enter a valid E-mail Address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Address',),
                  onSaved: (newValue) {
                    _userEmail=newValue;
                  },
                ),
                  if(!_isLogin)
                TextFormField(
                  key: ValueKey('username'),
                  validator:(value) {
                    if(value.isEmpty|| value.length<4){
                      return 'Please enter at least 4 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Username'),
                  onSaved: (newValue) {
                    _userName=newValue;
                  },
                ),
                TextFormField(
                  key: ValueKey('password'),
                  validator:(value) {
                    if(value.isEmpty|| value.length<6){
                      return 'Password must be 6 characters long';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  onSaved: (newValue) {
                    _userPassword=newValue;
                  },
                ),
                SizedBox(height: 12,),
                if(widget.isLoading)CircularProgressIndicator(),
                if(!widget.isLoading)SizedBox(width:100,
                  child: RaisedButton(child: Text(_isLogin?'Login':'SignUp'),onPressed:trySubmit,)),
                  if(!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin?'Create new Account':'I already have an account'),onPressed: (){
                    setState(() {
                      _isLogin= !_isLogin;
                    });
                },)
              ],
            ),),),
      ),
    ),
    );
  }
}
