import 'dart:async';
import 'dart:io';

import 'package:app2/shared/models/nsSNVModel.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app2/modules/predict/predict_module.dart';
import 'package:app2/modules/predictRequest/predictRequest_bloc.dart';
import 'package:flutter/services.dart';

class PredictRequestPage extends StatefulWidget {
  final Function onSuccess;
  const PredictRequestPage({
    Key key,
    this.onSuccess,
  }) : super(key: key);
  @override
  _PredictRequestPageState createState() => _PredictRequestPageState();
}

class _PredictRequestPageState extends State<PredictRequestPage> {
  var bloc = PredictModule.to.getBloc<PredictRequestBloc>();

  var chrList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "X",
    "Y",
    "M"
  ];

  var nucList = ["A", "C", "T", "G"];

  Controller controller;

  Future<void> _pickFile() async {
    FilePickerCross.pick(type: FileTypeCross.custom, fileExtension: 'txt,vcf')
        .then(
      (filePicker) => setState(() {
        if (filePicker.path != null && filePicker.path != "") {
          bloc.vcfFile = File(filePicker.path);
          bloc.vcfName =
              filePicker.path.split("/")[filePicker.path.split("/").length - 1];
        }
      }),
    );
    bloc.vcfContent = await bloc.vcfFile.readAsString();
  }

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Prediction"),
        //centerTitle: true,
      ),
      // resizeToAvoidBottomPadding: false,
      body: StreamBuilder<int>(
          stream: bloc.responseOut,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Timer(Duration(seconds: 2), () {
                bloc.reset();
                Navigator.pop(context);
              });
              return Center(
                child: Text(
                  "Request not completed, please try again later, if the problem persists contact our support",
                  style: TextStyle(fontSize: 25),
                ),
              );
            }

            if (snapshot.hasData) {
              if (snapshot.data == 0) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                Timer(Duration(seconds: 1), () {
                  bloc.reset();
                  Navigator.pop(context);
                });
                return Center(
                    child: Text(
                  "Successfully requested prediction!",
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
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'File: ' + bloc.vcfName,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _pickFile, // Usar a função _pickFile
                              child: Text('Upload VCF File'),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          maxLength: 2,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          onSaved: (String chrInput) {
                            bloc.chr = chrInput;
                          },
                          decoration: InputDecoration(
                            labelText: "Chromossome",
                            labelStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          validator: (String value) {
                            if (value.isEmpty &&
                                bloc.vcfName == "No vcf selected") {
                              return 'Field cannot be empty!';
                            }
                            if (!chrList.contains(value) &&
                                bloc.vcfName == "No vcf selected") {
                              return 'Invalid chromosome, please enter a valid chromosome!';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          onSaved: (String posInput) {
                            if (posInput.isNotEmpty) {
                              bloc.pos = int.parse(posInput);
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Position",
                            labelStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          validator: (String value) {
                            if (value.isEmpty &&
                                bloc.vcfName == "No vcf selected") {
                              return 'Field cannot be empty!';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          maxLength: 1,
                          maxLengthEnforced: true,
                          onSaved: (String refInput) {
                            bloc.ref = refInput;
                          },
                          decoration: InputDecoration(
                            labelText: "Reference nucleotide",
                            labelStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          validator: (String value) {
                            if (value.isEmpty &&
                                bloc.vcfName == "No vcf selected") {
                              return 'Field cannot be empty!';
                            }
                            if (!nucList.contains(value) &&
                                bloc.vcfName == "No vcf selected") {
                              return 'Invalid nucleotide!';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          maxLength: 1,
                          maxLengthEnforced: true,
                          onSaved: (String altInput) {
                            bloc.alt = altInput;
                          },
                          decoration: InputDecoration(
                            labelText: "Alternative nucleotide",
                            labelStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          validator: (String value) {
                            if (value.isEmpty &&
                                bloc.vcfName == "No vcf selected") {
                              return 'Field cannot be empty!';
                            }
                            if (!nucList.contains(value) &&
                                bloc.vcfName == "No vcf selected") {
                              return 'Invalid nucleotide!';
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
                                Colors.lightBlueAccent,
                                Colors.blueAccent,
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
                                          vcf: bloc.vcfContent),
                                    ),
                                  }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Request Prediction",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
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
                        return 'Field cannot be empty!';
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
                        return 'Field cannot be empty!';
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
                        return 'Field cannot be empty!';
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
