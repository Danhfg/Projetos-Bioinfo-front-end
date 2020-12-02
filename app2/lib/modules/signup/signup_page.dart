import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:app2/app/app_module.dart';
import 'package:app2/modules/predict/predict_page.dart';
import 'package:app2/modules/signup/signup_page.dart';
import 'package:app2/shared/auth/auth_bloc.dart';
import 'package:app2/shared/models/signinModel.dart';
import 'package:app2/shared/navigator/navigatorservice.dart';

/*class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}*/

class SignupPage extends StatelessWidget {
  AuthBloc auth = AppModule.to.getBloc<AuthBloc>();
  final _formKey = GlobalKey<FormState>();
  String aux;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
          stream: auth.responseOnOut,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 60, left: 40, right: 40),
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 128,
                          height: 128,
                          child: Image.asset("assets/logo.png"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          // autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          style: TextStyle(fontSize: 20),
                          onChanged: (String email) {
                            auth.username = email;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Campo não pode ser vazio!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          // autofocus: true,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            labelStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          style: TextStyle(fontSize: 20),
                          onChanged: (String psswd) {
                            auth.password = psswd;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Campo não pode ser vazio!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 60,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.3, 1],
                              colors: [
                                Color(0xFF689F38),
                                Color(0XFF388E3C),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: SizedBox.expand(
                            child: FlatButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Cadastrar",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              onPressed: () => {
                                if (_formKey.currentState.validate())
                                  {
                                    auth.responseOnIn.add(SigninModel(
                                        username: auth.username,
                                        password: auth.password)),
                                  }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          child: FlatButton(
                            child: Text(
                              "Cancelar",
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data == 0) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                Timer(Duration(seconds: 1), () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PredictPage(),
                    ),
                  );*/
                  navService.pushNamedAndRemoveUntil('/');
                  auth.dispose();
                });
                return Center(
                    child: Text(
                  "Cadastro efetuado com sucesso!",
                  style: TextStyle(fontSize: 25),
                ));
              }
            } else {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 60, left: 40, right: 40),
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 128,
                          height: 128,
                          child: Image.asset("assets/logo.png"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          // autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          style: TextStyle(fontSize: 20),
                          onChanged: (String email) {
                            auth.username = email;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Campo não pode ser vazio!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          // autofocus: true,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            labelStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          style: TextStyle(fontSize: 20),
                          onChanged: (String psswd) {
                            auth.password = psswd;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Campo não pode ser vazio!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 60,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.3, 1],
                              colors: [
                                Color(0xFF689F38),
                                Color(0XFF388E3C),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: SizedBox.expand(
                            child: FlatButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Cadastrar",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              onPressed: () => {
                                if (_formKey.currentState.validate())
                                  {
                                    auth.responseOnIn.add(SigninModel(
                                        username: auth.username,
                                        password: auth.password)),
                                  }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          child: FlatButton(
                            child: Text(
                              "Cancelar",
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
