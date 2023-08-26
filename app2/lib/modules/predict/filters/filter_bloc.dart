import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';

class SearchScreenBloc extends BlocBase {
  SearchScreenBloc();

  double patogenicidadeMachineLearning = 0;

  double patogenicidadeTradicional = 0;

  String selectedPredefinedList = 'All genes';

  bool isPathogenicSelected = true; // Checkbox padrão selecionado

  bool isBenignSelected = true; // Checkbox padrão selecionado

  bool isNFSelected = true; // Checkbox padrão selecionado

  String uploadedFileName = 'No file selected'; // Nome inicial do arquivo

  File geneList;

  void getUser() async {
    try {
      // this.user = await repo.getUserData();
    } catch (e) {
      throw (e);
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
