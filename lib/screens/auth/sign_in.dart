import 'package:coffee_dealer/services/auth.dart';
import 'package:coffee_dealer/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee_dealer/shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text Field State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Inicio Coffee Dealer'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Registrar'),
              onPressed: () {
                widget.toggleView();
              }
          )
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_50.png'),
              fit: BoxFit.cover,
            ),
          ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Introduce un correo' : null,
                    onChanged: (val) {
                    setState(() => email = val);
                  }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Introduce al menos 7 caracteres' : null,
                    onChanged: (val) {
                    setState(() => password = val);
                  }
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      setState(() => loading = true );
                      dynamic result = await _auth.signInWithEmail(email, password);
                      if(result == null) {
                        setState(() {
                          error = 'Credenciales erróneas';
                          loading = false;
                        });
                      }
                    }
                  }
                ),
                SizedBox(height: 12.0),
                Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0)
                )
              ],
            )
        )
      )
    );
  }
}
