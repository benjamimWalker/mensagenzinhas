import 'package:firebase_auth/firebase_auth.dart';
import 'package:mensagenzinhas/services/database.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  //Unique sign that will exist on this app
  Future signInAnon(String userName) async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User user = credential.user;
      user.updateProfile(displayName: userName);
      await DatatabaseService(uid: user.uid).updateMessages(
          {'message': 'Entrou', 'data': ''}, userName, DateTime.now());
      return user;
    } catch (exception) {
      print('OLHA... ERRO "$exception"');
      return null;
    }
  }

  //Stream
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //Signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print('Deu ruim: $exception');
      return null;
    }
  }
}
