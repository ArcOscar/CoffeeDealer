import 'package:coffee_dealer/models/user.dart';
import 'package:coffee_dealer/screens/auth/auth.dart';
import 'package:coffee_dealer/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return Home or Auth
    if(user == null)
      return Authenticate();
    else
      return Home();
  }
}
