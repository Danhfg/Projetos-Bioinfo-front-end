import 'package:app2/modules/predict/components/menuBar.dart';
import 'package:app2/modules/predict/components/menuBar_bloc.dart';
import 'package:app2/modules/predict/predict_bloc.dart';
import 'package:app2/modules/predict/predict_module.dart';
import 'package:app2/modules/predictRequest/predictRequest_page.dart';
import 'package:app2/modules/predictResult/predictResult_bloc.dart';
import 'package:app2/modules/predictResult/predictResult_page.dart';
import 'package:app2/shared/constants.dart';
import 'package:app2/shared/models/nsSNVGetModel.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';

class PredictPage extends StatefulWidget {
  final String title;
  const PredictPage({
    Key key,
    this.title = "Minhas Predições",
  }) : super(key: key);

  @override
  _PredictPageState createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  var bloc = PredictModule.to.getBloc<PredictBloc>();
  var blocRequest = PredictModule.to.getBloc<PredictResultBloc>();
  var menuBarBloc = PredictModule.to.getBloc<MenuBarBloc>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<Null> _handleRefresh() async {
    bloc.getResults();
  }

  showSnack() {
    return scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Nova análise adicionada!'),
      ),
    );
  }

  @override
  void initState() {
    //blocAuth.login();
    bloc.getResults();
    menuBarBloc.getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      drawer: MenuBar(),
      appBar: AppBar(
        //title: Text(widget.title),
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.menu_sharp),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
              // It will cover 20% of our total height
              height: size.height * 0.2,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: 36 + kDefaultPadding,
                    ),
                    height: size.height * 0.2 - 27,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Bem vindo!',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Image.asset("assets/logo.png")
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: kPrimaryColor.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Procurar",
                          hintStyle: TextStyle(
                            color: kPrimaryColor.withOpacity(0.40),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            PredictLine(),
            // Container(
            //   child: SingleChildScrollView(
            //     child: StreamBuilder<List<NsSNVGETModel>>(
            //       stream: bloc.responseOut,
            //       builder: (context, snapshot) {
            //         print(snapshot.data);
            //         if (snapshot.hasError) {
            //           print(snapshot);
            //           return Center(
            //             child: Text(
            //               snapshot.error.toString(),
            //             ),
            //           );
            //         }
            //         if (snapshot.hasData) {
            //           return Expanded(
            //             child: RefreshIndicator(
            //               onRefresh: _handleRefresh,
            //               child: Column(
            //                 children: snapshot.data
            //                     .map(
            //                       (e) => Column(
            //                         children: [
            //                           ListTile(
            //                             title: Text(
            //                               "Cromossomo " +
            //                                   e.result.split("\t")[0] +
            //                                   " posição " +
            //                                   e.result.split("\t")[1],
            //                               style: TextStyle(
            //                                   fontSize: 20,
            //                                   fontWeight: FontWeight.bold),
            //                             ),
            //                             subtitle: Text(
            //                               "Mutação " +
            //                                   e.result.split("\t")[3] +
            //                                   " Referência " +
            //                                   e.result.split("\t")[4],
            //                             ),
            //                             trailing: Icon(
            //                               Icons.delete,
            //                             ),
            //                             // onTap: () {
            //                             //   blocRequest
            //                             //       .processPrediction(e.result);
            //                             //   Navigator.push(
            //                             //     context,
            //                             //     MaterialPageRoute(
            //                             //       builder: (context) =>
            //                             //           PredictResultPage(),
            //                             //     ),
            //                             //   );
            //                             // },
            //                           ),
            //                           SingleChildScrollView(
            //                             scrollDirection: Axis.horizontal,
            //                             child: Row(
            //                               children: <Widget>[
            //                                 Container(
            //                                   padding: EdgeInsets.all(
            //                                       kDefaultPadding / 2),
            //                                   margin: EdgeInsets.only(
            //                                     left: kDefaultPadding,
            //                                     top: kDefaultPadding / 2,
            //                                     bottom: kDefaultPadding * 2.5,
            //                                   ),
            //                                   width: size.width * 0.3,
            //                                   height: size.width * 0.35,
            //                                   child: Column(
            //                                     children: [
            //                                       Center(
            //                                         child: Text(
            //                                           bloc
            //                                               .getNdamage(e.result)
            //                                               .toString(),
            //                                           style: TextStyle(
            //                                             fontSize: 70,
            //                                             color: bloc.getColor(
            //                                               bloc.getNdamage(
            //                                                 e.result,
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                       Container(
            //                                         decoration: BoxDecoration(
            //                                           color: Colors.white,
            //                                           boxShadow: [
            //                                             BoxShadow(
            //                                               blurRadius: 50,
            //                                               color: kPrimaryColor
            //                                                   .withOpacity(0.2),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                         child: Text(
            //                                           "NDAMAGE",
            //                                         ),
            //                                       ),
            //                                       Container(
            //                                         decoration: BoxDecoration(
            //                                           color: Colors.white,
            //                                           boxShadow: [
            //                                             BoxShadow(
            //                                               blurRadius: 50,
            //                                               color: kPrimaryColor
            //                                                   .withOpacity(0.2),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                         child: Text(
            //                                           "ÁRVORE",
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   decoration: BoxDecoration(
            //                                     color: Colors.white,
            //                                     borderRadius:
            //                                         BorderRadius.circular(5),
            //                                     boxShadow: [
            //                                       BoxShadow(
            //                                         offset: Offset(0, 10),
            //                                         blurRadius: 25,
            //                                         color: Colors.black
            //                                             .withOpacity(0.1),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ),
            //                                 Container(
            //                                   padding: EdgeInsets.all(
            //                                       kDefaultPadding / 2),
            //                                   margin: EdgeInsets.only(
            //                                     left: kDefaultPadding,
            //                                     top: kDefaultPadding / 2,
            //                                     bottom: kDefaultPadding * 2.5,
            //                                   ),
            //                                   width: size.width * 0.3,
            //                                   height: size.width * 0.35,
            //                                   child: Column(
            //                                     children: [
            //                                       Center(
            //                                         child: Text(
            //                                           "55",
            //                                           style: TextStyle(
            //                                             fontSize: 70,
            //                                             color: Colors.red[400],
            //                                           ),
            //                                         ),
            //                                       ),
            //                                       Container(
            //                                         decoration: BoxDecoration(
            //                                           color: Colors.white,
            //                                           boxShadow: [
            //                                             BoxShadow(
            //                                               blurRadius: 50,
            //                                               color: kPrimaryColor
            //                                                   .withOpacity(0.2),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                         child: Text(
            //                                           "NDAMAGE",
            //                                         ),
            //                                       ),
            //                                       Container(
            //                                         decoration: BoxDecoration(
            //                                           color: Colors.white,
            //                                           boxShadow: [
            //                                             BoxShadow(
            //                                               blurRadius: 50,
            //                                               color: kPrimaryColor
            //                                                   .withOpacity(0.2),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                         child: Text(
            //                                           "deep l".toUpperCase(),
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   decoration: BoxDecoration(
            //                                     color: Colors.white,
            //                                     borderRadius:
            //                                         BorderRadius.circular(5),
            //                                     boxShadow: [
            //                                       BoxShadow(
            //                                         offset: Offset(0, 10),
            //                                         blurRadius: 25,
            //                                         color: Colors.black
            //                                             .withOpacity(0.1),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ),
            //                                 GestureDetector(
            //                                   onTap: () {
            //                                     blocRequest.processPrediction(
            //                                       e.result,
            //                                     );
            //                                     Navigator.push(
            //                                       context,
            //                                       MaterialPageRoute(
            //                                         builder: (context) =>
            //                                             PredictResultPage(),
            //                                       ),
            //                                     );
            //                                   },
            //                                   child: Container(
            //                                     padding: EdgeInsets.all(
            //                                         kDefaultPadding / 2),
            //                                     margin: EdgeInsets.only(
            //                                       left: kDefaultPadding,
            //                                       top: kDefaultPadding / 2,
            //                                       bottom: kDefaultPadding * 2.5,
            //                                       right: kDefaultPadding,
            //                                     ),
            //                                     width: size.width * 0.3,
            //                                     height: size.width * 0.35,
            //                                     child: Column(
            //                                       children: [
            //                                         Center(
            //                                           child: Icon(
            //                                             // Icons.ac_unit,
            //                                             Entypo.flow_tree,
            //                                             size: size.width * 0.21,
            //                                           ),
            //                                         ),
            //                                         Container(
            //                                           decoration: BoxDecoration(
            //                                             color: Colors.white,
            //                                             boxShadow: [
            //                                               BoxShadow(
            //                                                 blurRadius: 50,
            //                                                 color: kPrimaryColor
            //                                                     .withOpacity(
            //                                                         0.2),
            //                                               ),
            //                                             ],
            //                                           ),
            //                                           child: Text(
            //                                             "ÁRVORE",
            //                                           ),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                     decoration: BoxDecoration(
            //                                       color: Colors.white,
            //                                       borderRadius:
            //                                           BorderRadius.circular(5),
            //                                       boxShadow: [
            //                                         BoxShadow(
            //                                           offset: Offset(0, 10),
            //                                           blurRadius: 25,
            //                                           color: Colors.black
            //                                               .withOpacity(0.1),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     )
            //                     .toList(),

            //                 /*
            //               ListView.builder(
            //                 physics: const AlwaysScrollableScrollPhysics(),
            //                 itemCount: snapshot.data.length,
            //                 itemBuilder: (context, index) {
            //                   var nsSnv = snapshot.data[index];
            //                   if (!nsSnv.alive) {
            //                     return ListTile(
            //                       title: Text("Posição " +
            //                           nsSnv.pos.toString() +
            //                           " e mutação " +
            //                           nsSnv.alt),
            //                       subtitle: Text("Cromossomo " +
            //                           nsSnv.chr +
            //                           " e referência " +
            //                           nsSnv.ref),
            //                       trailing: Icon(
            //                         Icons.check_circle,
            //                         color: Colors.lightGreen,
            //                       ),
            //                       onTap: () {
            //                         blocRequest.processPrediction(nsSnv.result);
            //                         Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                             builder: (context) =>
            //                                 PredictResultPage(),
            //                           ),
            //                         );
            //                       },
            //                     );
            //                   } else {
            //                     return ListTile(
            //                       title: Text("Posição " +
            //                           nsSnv.pos.toString() +
            //                           " e mutação " +
            //                           nsSnv.alt),
            //                       subtitle: Text("Cromossomo " +
            //                           nsSnv.chr +
            //                           " e referência " +
            //                           nsSnv.ref),
            //                       trailing: Icon(
            //                         Icons.more_horiz,
            //                         color: Colors.yellowAccent,
            //                       ),
            //                       onTap: () {
            //                         blocRequest.processPrediction(nsSnv.result);
            //                         showDialog(
            //                           context: context,
            //                           builder: (context) => AlertDialog(
            //                             content: Text(
            //                                 "Requisição ainda não processada, espere alguns minutos!"),
            //                           ),
            //                         );
            //                       },
            //                     );
            //                   }
            //                 },
            //               ),
            //             ],*/
            //               ),
            //             ),
            //           );
            //         } else {
            //           return Center(child: CircularProgressIndicator());
            //         }
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      /*Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<List<NsSNVGETModel>>(
              stream: bloc.responseOut,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot);
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: _handleRefresh,
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              var nsSnv = snapshot.data[index];
                              if (!nsSnv.alive) {
                                return ListTile(
                                  title: Text("Posição " +
                                      nsSnv.pos.toString() +
                                      " e mutação " +
                                      nsSnv.alt),
                                  subtitle: Text("Cromossomo " +
                                      nsSnv.chr +
                                      " e referência " +
                                      nsSnv.ref),
                                  trailing: Icon(
                                    Icons.check_circle,
                                    color: Colors.lightGreen,
                                  ),
                                  onTap: () {
                                    blocRequest.processPrediction(nsSnv.result);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PredictResultPage(),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return ListTile(
                                  title: Text("Posição " +
                                      nsSnv.pos.toString() +
                                      " e mutação " +
                                      nsSnv.alt),
                                  subtitle: Text("Cromossomo " +
                                      nsSnv.chr +
                                      " e referência " +
                                      nsSnv.ref),
                                  trailing: Icon(
                                    Icons.more_horiz,
                                    color: Colors.yellowAccent,
                                  ),
                                  onTap: () {
                                    blocRequest.processPrediction(nsSnv.result);
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Text(
                                            "Requisição ainda não processada, espere alguns minutos!"),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  );
                  /*return Column(
              children: snapshot.data
                  .map((e) => ListTile(
                        title: Text(e.result),
                      ))
                  .toList(),
            );*/
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),*/
      /*body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          SingleChildScrollView(
            child: StreamBuilder<List<NsSNVGETModel>>(
              stream: bloc.responseOut,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot);
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data
                        .map((e) => ListTile(
                              title: Text(e.result),
                            ))
                        .toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      */
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PredictRequestPage(
                  /* onSuccess: bloc.postDecisionTree, */
                  ),
            ),
          );
        },
      ),
    );
  }
}

class PredictLine extends StatelessWidget {
  const PredictLine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: createListView(),
    );
  }

  Widget createListView() {
    var bloc = PredictModule.to.getBloc<PredictBloc>();
    return new ListView.builder(
        itemCount: bloc.offset,
        itemBuilder: (BuildContext context, int index) {
          var values = bloc.list;

          if (index >= bloc.list.length - 1) {
            ++bloc.offset;
            bloc.getResult();
          }
          return new Container(
            child: new ListTile(
              title: new Column(children: <Widget>[
                new Text(values[index].identification ?? ""),
              ]),
            ),
          );
        });
  }
}
