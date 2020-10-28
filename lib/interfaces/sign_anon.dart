import 'package:flutter/material.dart';
import 'package:mensagenzinhas/services/auth.dart';

class SignInAnon extends StatefulWidget {
  @override
  _SignInAnonState createState() => _SignInAnonState();
}

class _SignInAnonState extends State<SignInAnon> {
  String userName = 'User name here';
  String possibleError = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Nome',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Bota um nome aí vai, não seja tímido';
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    userName = val;
                  });
                },
              ),
              Text(
                  'O nome que você registrar não poderá ser mudado, escolha com sabedoria'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 15,
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.signInAnon(userName);

                        if (result == null) {
                          setState(() {
                            possibleError =
                                'Oops... Algo deu errado, mas tenta de novo vai';
                          });
                        }
                      }
                    },
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                possibleError,
                style: TextStyle(color: Colors.red, fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );
  }
}
