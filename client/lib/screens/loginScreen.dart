import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

var token;

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _EmailError = '';
  late String _PasswordError = '';
  late String email = '';
  late String password = '';
  late bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: KloginBackgroundDecoration,
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  decoration: KMiddleContainerDecoration,
                  constraints: BoxConstraints(
                      minHeight: size.height * 0.5,
                      maxHeight: size.height * 0.85),
                  width: size.width * 0.85,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Image(
                            image: AssetImage("images/logo.jpg"),
                            height: size.height * 0.15,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            child: Form(
                              key: _formKey,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 30, left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text('Email : '),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    TextFormField(
                                      style: TextStyle(fontSize: 13),
                                      onChanged: (value) {
                                        email = value;
                                        setState(() {
                                          _EmailError = '';
                                        });
                                      },
                                      decoration: KdecorationTextField.copyWith(
                                        hintText: "Enter your email address",
                                        errorText: _EmailError.isEmpty
                                            ? null
                                            : _EmailError,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.035,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text('Password : '),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    TextFormField(
                                      style: TextStyle(fontSize: 13),
                                      obscureText: _passwordVisible,
                                      onChanged: (value) {
                                        setState(() {
                                          _PasswordError = '';
                                        });
                                        password = value;
                                      },
                                      decoration: KdecorationTextField.copyWith(
                                        hintText: "Enter your password",
                                        errorText: _PasswordError.isEmpty
                                            ? null
                                            : _PasswordError,
                                        suffixIcon: IconButton(
                                          icon: _passwordVisible
                                              ? Icon(
                                                  Icons.visibility_off,
                                                )
                                              : Icon(Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.055),
                                        child: Material(
                                          elevation: 5,
                                          color: Color(0xff5277B4),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: MaterialButton(
                                            onPressed: () async {
                                              setState(() {
                                                if (email.isEmpty ||
                                                    email == ' ') {
                                                  _EmailError =
                                                      "Please provide your Email .";
                                                } else {
                                                  _EmailError = '';
                                                }
                                                if (password.isEmpty ||
                                                    password == ' ') {
                                                  _PasswordError =
                                                      "Please provide your Password .";
                                                } else {
                                                  _PasswordError = '';
                                                }
                                              });

                                              var data = {
                                                "email": email,
                                                "password": password
                                              };
                                              var x = jsonEncode(data);

                                              try {
                                                final res = await http.post(
                                                    Uri.parse(
                                                        "$Kurl/api/v1/users/login"),
                                                    headers: {
                                                      'Content-Type':
                                                          'application/json; charset=UTF-8',
                                                    },
                                                    body: x);

                                                var resBody =
                                                    jsonDecode(res.body);

                                                if (res.statusCode == 200) {
                                                  token = resBody['token'];

                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  await prefs.setString(
                                                      'token', token);
                                                  Navigator.pushNamed(
                                                      context, '/homePage');
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      padding:
                                                          EdgeInsets.all(13),
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                      content: Text(
                                                        resBody['message'],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              } catch (err) {
                                                print(err);
                                              }
                                            },
                                            minWidth: 120,
                                            height: 50,
                                            child: Text(
                                              'LogIn',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Text('or')),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
                                    Flexible(
                                      flex: 0,
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: (() async {
                                            var data = {
                                              "email": email,
                                            };
                                            var x = jsonEncode(data);
                                            print(x);
                                            try {
                                              final res = await http.post(
                                                  Uri.parse(
                                                      "$Kurl/api/v1/users/forgotpassword"),
                                                  headers: {
                                                    'Content-Type':
                                                        'application/json; charset=UTF-8',
                                                  },
                                                  body: x);
                                              print(x);
                                              var decodedData =
                                                  jsonDecode(res.body);
                                              print(decodedData);
                                            } catch (e) {
                                              print(e);
                                            }
                                          }),
                                          child: Container(
                                            child: Text(
                                              'Reset Password',
                                              style: KresetPasswordTextStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
