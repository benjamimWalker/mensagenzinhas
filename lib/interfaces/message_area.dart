import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mensagenzinhas/interfaces/messages_area.dart';
import 'package:mensagenzinhas/services/auth.dart';
import 'package:mensagenzinhas/services/database.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class MessageArea extends StatelessWidget {
  final AuthService _auth = AuthService();
  String userName = '...';
  @override
  Widget build(BuildContext context) {
    String mensagemProvisoria = '';
    final user = Provider.of<User>(context);
    if (user.displayName == null) {
      runApp(MyApp());
    } else {
      userName = user.displayName;
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        child: TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Digite sua mensagem',
                            filled: true,
                          ),
                          onChanged: (value) {
                            mensagemProvisoria = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(65.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: RaisedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await DatatabaseService().updateMessages({
                                'message': mensagemProvisoria,
                                'data':
                                    '${DateTime.now().day}/${DateTime.now().month} | ${DateTime.now().hour}:${DateTime.now().minute}'
                              }, userName, DateTime.now());
                              mensagemProvisoria = '';
                            },
                            child: Text('Enviar mensagem'),
                          ),
                        ),
                      )
                    ],
                  ));
        },
        child: Icon(Icons.message),
      ),
      appBar: AppBar(
        title: Text('Mensagens'),
      ),
      body: MessagesArea(user.displayName),
    );
  }
}
