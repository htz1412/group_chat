import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/picker/profile_image_picker.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();

  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitAuthForm;

  final bool isLoading;

  const AuthForm(this.submitAuthForm, this.isLoading);
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File _userPickedImage;

  void _pickedImage(File image) {
    _userPickedImage = image;
  }

  void _tryLogin() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userPickedImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitAuthForm(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName,
        _userPickedImage,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 14,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) ProfileImagePicker(_pickedImage),
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _userEmail = value;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('userName'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty || value.length <= 3) {
                            return 'Please enter at lease 4 characters,';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userName = value;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value.isEmpty || value.length <= 6) {
                          return 'Passoword must be at lease 6 characters,';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 20),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      ElevatedButton(
                        onPressed: _tryLogin,
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor,
                          elevation: 0,
                          minimumSize: Size(120, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          _isLogin ? 'Login' : 'Sign up',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    if (!widget.isLoading)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Theme.of(context).accentColor,
                        ),
                        child: Text(
                          _isLogin
                              ? 'Create new account'
                              : 'Already have an account',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
