import 'package:app2/modules/home/home_bloc.dart';
import 'package:app2/modules/home/home_module.dart';
import 'package:app2/modules/predict/predict_page.dart';
import 'package:app2/shared/auth/auth_bloc.dart';
import 'package:app2/shared/models/nsSNVGetModel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bloc = HomeModule.to.getBloc<HomeBloc>();
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<NsSNVGETModel>>(
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
                        return ListTile(
                          title: Text("Posição " +
                              nsSnv.pos.toString() +
                              " e mutação " +
                              nsSnv.alt),
                          subtitle: Text("Cromossomo " +
                              nsSnv.chr +
                              " e referência " +
                              nsSnv.ref),
                        );
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
              builder: (context) => PredictPage(
                  /* onSuccess: bloc.postDecisionTree, */
                  ),
            ),
          );
        },
      ),
    );
  }
}
