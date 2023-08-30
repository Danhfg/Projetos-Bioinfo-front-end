import 'dart:io';

import 'package:app2/shared/constants.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class SearchScreenBloc extends BlocBase {
  SearchScreenBloc() {
    this.selectedPredefinedList = 'All genes';
    this.curentList = 'All genes';
  }

  double patogenicidadeMachineLearning = 0;

  double patogenicidadeTradicional = 0;

  String selectedPredefinedList = 'All genes';

  bool isPathogenicSelected = true; // Checkbox padrão selecionado

  bool isBenignSelected = true; // Checkbox padrão selecionado

  bool isNFSelected = true; // Checkbox padrão selecionado

  String uploadedFileName = 'No file selected'; // Nome inicial do arquivo

  File geneList;

  String curentList = 'All genes';

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }

  void updateList(String newValue) {
    if (newValue == 'All genes') {
      this.curentList = 'All genes';
    } else if (newValue == 'Hallmark genes') {
      this.curentList = hallmark;
    } else if (newValue == 'DNA-rep genes') {
      this.curentList = dnarep;
    } else if (newValue == 'Rep-rep genes') {
      this.curentList = reprep;
    }
  }
}
