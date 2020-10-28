import 'package:cloud_firestore/cloud_firestore.dart';

import '../message.dart';

class DatatabaseService {
  final String uid;
  //collection reference
  final CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('message');

  DatatabaseService({this.uid});

  Future updateMessages(
      Map<String, String> message, String nome, DateTime data2) async {
    return await messageCollection
        .doc(uid)
        .set({'message': message, 'nome': nome, 'data2': data2});
  }

  List<Mensagem> _mensagemFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Mensagem(
          mensagem: doc.data()['message']['message'],
          autor: doc.data()['nome'],
          data: doc.data()['message']['data']);
    }).toList();
  }

  Stream<List<Mensagem>> get getMessageSnapshot {
    return messageCollection
        .orderBy('data2')
        .snapshots()
        .map(_mensagemFromSnapshot);
  }
}
