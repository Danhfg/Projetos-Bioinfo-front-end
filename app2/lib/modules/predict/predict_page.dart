import 'dart:async';

import 'package:app2/shared/models/nsSNVModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app2/modules/home/home_module.dart';
import 'package:app2/modules/predict/predict_bloc.dart';

class PredictPage extends StatefulWidget {
  final Function onSuccess;
  const PredictPage({
    Key key,
    this.onSuccess,
  }) : super(key: key);
  @override
  _PredictPageState createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  var bloc = HomeModule.to.getBloc<PredictBloc>();

  Controller controller;

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Predição"),
        centerTitle: true,
      ),
      // resizeToAvoidBottomPadding: false,
      body: StreamBuilder<int>(
          stream: bloc.responseOut,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("ERROR");
              return Center(
                child: Text(
                  "${snapshot.error}",
                  style: TextStyle(fontSize: 25),
                ),
              );
            }
            print("PASS");

            if (snapshot.hasData) {
              if (snapshot.data == 0) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                Timer(Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
                return Center(
                    child: Text(
                  "Inserido com sucesso!",
                  style: TextStyle(fontSize: 25),
                ));
              }
            } else {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 60,
                    left: 40,
                    right: 40,
                  ),
                  color: Colors.white,
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            onSaved: (String chrInput) {
                              bloc.chr = chrInput;
                            },
                            decoration: InputDecoration(
                              labelText: "Cromossomo",
                              labelStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Campo não pdoe ser vazio!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            onSaved: (String posInput) {
                              bloc.pos = int.parse(posInput);
                            },
                            decoration: InputDecoration(
                              labelText: "Posição",
                              labelStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
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
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            onSaved: (String refInput) {
                              bloc.ref = refInput;
                            },
                            decoration: InputDecoration(
                                labelText: "Nucleotídeo referência",
                                labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            onSaved: (String altInput) {
                              bloc.alt = altInput;
                            },
                            decoration: InputDecoration(
                              labelText: "Nucleotídeo alternativo",
                              labelStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Campo não pdoe ser vazio!';
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
                                  Colors.blueAccent,
                                  Colors.lightBlueAccent,
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: SizedBox.expand(
                              child: FlatButton(
                                onPressed: () => {
                                  if (controller.validate())
                                    {
                                      bloc.responseIn.add(
                                        NsSNVModel(
                                          chr: bloc.chr,
                                          pos: bloc.pos,
                                          ref: bloc.ref,
                                          alt: bloc.alt,
                                        ),
                                      ),
                                      /*bloc.postDecisionTree(
                                        NsSNVModel(
                                          chr: bloc.chr,
                                          pos: bloc.pos,
                                          ref: bloc.ref,
                                          alt: bloc.alt,
                                        ),
                                      ),*/
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Text("Result: "),
                                        ),
                                      ),
                                    }
                                  else
                                    {
                                      {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            // title: Text('Are you sure?'),
                                            content: Text("ERROR"),
                                          ),
                                        ),
                                      },
                                    }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Arvore de decisão",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    Container(
                                      child: SizedBox(
                                        child: Text("?"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                                stops: [0.6, 1],
                                colors: [
                                  Colors.green,
                                  Colors.greenAccent,
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: SizedBox.expand(
                              child: FlatButton(
                                onPressed: () => {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Mútiplos preditores",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    Container(
                                      child: SizedBox(
                                        child: Text("?"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              );
            }
          }),
      /*SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 60,
            left: 40,
            right: 40,
          ),
          color: Colors.white,
          child: Form(
            key: controller.formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    onSaved: (String chrInput) {
                      bloc.chr = chrInput;
                    },
                    decoration: InputDecoration(
                      labelText: "Cromossomo",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Campo não pdoe ser vazio!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    onSaved: (String posInput) {
                      bloc.pos = int.parse(posInput);
                    },
                    decoration: InputDecoration(
                      labelText: "Posição",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
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
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    onSaved: (String refInput) {
                      bloc.ref = refInput;
                    },
                    decoration: InputDecoration(
                        labelText: "Nucleotídeo referência",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    onSaved: (String altInput) {
                      bloc.alt = altInput;
                    },
                    decoration: InputDecoration(
                      labelText: "Nucleotídeo alternativo",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Campo não pdoe ser vazio!';
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
                          Colors.blueAccent,
                          Colors.lightBlueAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: SizedBox.expand(
                      child: FlatButton(
                        onPressed: () => {
                          if (controller.validate())
                            {
                              bloc.postDecisionTree(
                                NsSNVModel(
                                  chr: bloc.chr,
                                  pos: bloc.pos,
                                  ref: bloc.ref,
                                  alt: bloc.alt,
                                ),
                              ),
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text("Result: "),
                                ),
                              ),
                            }
                          else
                            {
                              {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    // title: Text('Are you sure?'),
                                    content: Text("ERROR"),
                                  ),
                                ),
                              },
                            }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Arvore de decisão",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Container(
                              child: SizedBox(
                                child: Text("?"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                        stops: [0.6, 1],
                        colors: [
                          Colors.green,
                          Colors.greenAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: SizedBox.expand(
                      child: FlatButton(
                        onPressed: () => {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Mútiplos preditores",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Container(
                              child: SizedBox(
                                child: Text("?"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),*/
    );
  }
}

class Controller {
  var formKey = GlobalKey<FormState>();

  bool validate() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
}
