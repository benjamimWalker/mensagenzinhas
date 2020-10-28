import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mensagenzinhas/interfaces/message_area.dart';
import 'package:mensagenzinhas/interfaces/sign_anon.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null)
      return SignInAnon();
    else
      return MessageArea();
  }
}
