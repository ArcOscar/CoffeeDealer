import 'package:coffee_dealer/screens/home/coffees_form.dart';
import 'package:coffee_dealer/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee_dealer/services/database.dart';
import 'package:provider/provider.dart';
import 'package:coffee_dealer/screens/home/coffee_list.dart';
import 'package:coffee_dealer/models/coffee.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showCoffeesPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: CoffeesForm()
        );
      });
    }

    return StreamProvider<List<Coffee>>.value(
      value: DatabaseService().coffees,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee Dealer'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.free_breakfast),
              label: Text('Café'),
              onPressed: () => _showCoffeesPanel(),
            ),
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Cerrar Sesión'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
            child: CoffeeList()
        ),
      ),
    );
  }
}
