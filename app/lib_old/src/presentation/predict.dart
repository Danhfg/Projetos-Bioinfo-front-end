import 'package:flutter/material.dart';

import 'package:app/src/data/datasource/api.dart';

class PredictPage extends StatefulWidget {
  PredictPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PredictPageState createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  final Api api = Api();
  String _chr;
  int _pos;
  String _ref;
  String _alt;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Predição"),
      ),
      // resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 60,
            left: 40,
            right: 40,
          ),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    onChanged: (String chrInput) {
                      _chr = chrInput;
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
                    onChanged: (String posInput) {
                      _pos = int.parse(posInput);
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
                    keyboardType: TextInputType.text,
                    onChanged: (String refInput) {
                      _ref = refInput;
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
                    onChanged: (String altInput) {
                      _alt = altInput;
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
                          if (_formKey.currentState.validate())
                            {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  // title: Text('Are you sure?'),
                                  content: Text(_chr),
                                ),
                                // actions: <Widget>[
                                // FlatButton(
                                // onPressed: () => Navigator.of(context).pop(
                                // false), //  We can return any object from here
                                // child: Text('NO')),
                                // FlatButton(
                                // onPressed: () => Navigator.of(context).pop(
                                // true), //  We can return any object from here
                                // child: Text('YES'))
                                // ],
                                // ),
                              ),
                              api.decisionTree(_chr, _pos, _ref, _alt),
                            }
                          // if (_formKey.currentState.validate())
                          // {
                          // Scaffold.of(context).showSnackBar(
                          // SnackBar(
                          // content: Text('Processando Requisição'),
                          // ),
                          // ),
                          // AlertDialog(
                          // content: api.decisionTree(_chr, _pos, _ref, _alt),
                          // ),
                          // },
                          // Navigator.of(context, rootNavigator: true)
                          // .pop('api.decisionTree(_chr, _pos, _ref, _alt)'),
                          // log('The value of the input is: $_chr'),
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
      ),
    );
  }
}
