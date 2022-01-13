import 'package:app2/modules/predict/predict_module.dart';
import 'package:app2/modules/predictResultML/predictResultML_bloc.dart';
import 'package:flutter/material.dart';

class PredictResultPageML extends StatefulWidget {
  @override
  _PredictResultPageMLState createState() => _PredictResultPageMLState();
}

class _PredictResultPageMLState extends State<PredictResultPageML> {
  var bloc = PredictModule.to.getBloc<PredictResultMLBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultado"),
        //centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("Linear Discriminant Analysis:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['LinearDiscriminantAnalysis']
                      .contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['LinearDiscriminantAnalysis']
                            .contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("Quadratic Discriminant Analysis:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['QuadraticDiscriminantAnalysis']
                      .contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['QuadraticDiscriminantAnalysis']
                            .contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("AdaBoost:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['AdaBoostClassifier'].contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color:
                        (bloc.allPredictors['AdaBoostClassifier'].contains("1"))
                            ? Colors.red
                            : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("Bagging:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['BaggingClassifier'].contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color:
                        (bloc.allPredictors['BaggingClassifier'].contains("1"))
                            ? Colors.red
                            : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("Extra Trees:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['ExtraTreesClassifier']
                      .contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['ExtraTreesClassifier']
                            .contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("Random Forest:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['RandomForestClassifier']
                      .contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['RandomForestClassifier']
                            .contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("Logistic Regression:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['LogisticRegression'].contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color:
                        (bloc.allPredictors['LogisticRegression'].contains("1"))
                            ? Colors.red
                            : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("Bernoulli Naive Bayes:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['BernoulliNB'].contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['BernoulliNB'].contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("Gaussian Naive Bayes:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['GaussianNB'].contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['GaussianNB'].contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("K Nearest Neighbors:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['KNeighborsClassifier']
                      .contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['KNeighborsClassifier']
                            .contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("Multilayer Perceptron:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['MLPClassifier'].contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['MLPClassifier'].contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("Support Vector Machines (Linear kernel):"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['LinearSVC'].contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['LinearSVC'].contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("Nu-Support Vector Machines:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['NuSVC'].contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['NuSVC'].contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("Support Vector Machines (RBF kernel):"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['SVC'].contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['SVC'].contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("SKLearn Decision Tree:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['DecisionTreeClassifier']
                      .contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['DecisionTreeClassifier']
                            .contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
            ListTile(
              title: Text("Extra Tree:"),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors['ExtraTreeClassifier'].contains("1")) {
                    return "Mutação Patogênica";
                  }
                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['ExtraTreeClassifier']
                            .contains("1"))
                        ? Colors.red
                        : Colors.lightGreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
