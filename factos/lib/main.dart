// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

void main() {
  runApp(
    Factos(),
  );
}

class Factos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Factos',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff182C4A),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('images/mscLogo.png'),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 40,
                child: ListTile(
                  leading: Icon(
                    Icons.domain,
                  ),
                  trailing: Text(
                    'MSC KIIT',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lobster',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              TextField(),
              SizedBox(
                height: 20,
              ),
              TextField(),
              ElevatedButton(
                onPressed: () {},
                child: Text('Sign In!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
