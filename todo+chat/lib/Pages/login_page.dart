import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<TextEditingController> _controller = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  final formKey = GlobalKey<FormState>();
  bool isLoginMode = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height:
                MediaQuery.of(context).size.height * (isLoginMode ? 0.4 : 0.5),
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (val) {
                        if (val == null) {
                          return "Invalid Email";
                        }
                        if (val.contains('@')) {
                          return null;
                        }
                        return "Invalid Email";
                      },
                      controller: _controller[0],
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val == null || val.length < 6) {
                          return "Password Length should atleast be 6";
                        }
                        return null;
                      },
                      controller: _controller[1],
                    ),
                    if (!isLoginMode)
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: "Enter your name"),
                        validator: (val) {
                          if (val == null || val.length < 4) {
                            return "Length of name should atleast be 4";
                          }
                          return null;
                        },
                        controller: _controller[2],
                      ),
                    TextButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.zero)),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              if (isLoginMode) {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _controller[0].text,
                                        password: _controller[1].text);
                              } else {
                                final _user = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _controller[0].text,
                                        password: _controller[1].text)
                                    .then((value) async {
                                  await FirebaseAuth.instance.currentUser!
                                      .updateDisplayName(_controller[2].text);
                                });
                              }
                            } catch (error) {
                              print(error);
                            } finally {
                              setState(() {
                                if (!isLoginMode) isLoading = false;
                              });
                            }
                          }
                        },
                        child: Text(isLoginMode ? "Login" : "Register")),
                    TextButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.zero)),
                        onPressed: () {
                          setState(() {
                            isLoginMode = !isLoginMode;
                          });
                        },
                        child: Text(isLoginMode
                            ? "Create a new account"
                            : "Login to an existing account"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
