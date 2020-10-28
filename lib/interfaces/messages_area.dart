import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mensagenzinhas/message.dart';
import 'package:mensagenzinhas/services/database.dart';
import 'package:provider/provider.dart';

class MessagesArea extends StatefulWidget {
  MessagesArea(this.name, {Key key}) : super(key: key);
  final name;

  @override
  _MessagesAreaState createState() => _MessagesAreaState(name);
}

class _MessagesAreaState extends State<MessagesArea> {
  final name;

  _MessagesAreaState(this.name);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<List<Mensagem>>(
        stream: DatatabaseService().getMessageSnapshot,
        builder: (context, snapshot) {
          return Container(
            child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 2),
                      child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Text(
                                    snapshot.data[index].autor,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  height: 7,
                                ),
                                SelectableText(
                                  snapshot.data[index].mensagem,
                                ),
                                Container(
                                  width: double.infinity,
                                  alignment: AlignmentDirectional.bottomEnd,
                                  child: Text(
                                    snapshot.data[index].data,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )),
          );
        });
  }
}
