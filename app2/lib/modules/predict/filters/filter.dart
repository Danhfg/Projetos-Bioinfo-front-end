import 'dart:io';

import 'package:app2/modules/predict/filters/filter_bloc.dart';
import 'package:app2/modules/predict/predict_module.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchScreenBloc searchScreenBloc =
      PredictModule.to.getBloc<SearchScreenBloc>();
  // double patogenicidadeMachineLearning = 0;
  // double patogenicidadeTradicional = 0;
  // String selectedPredefinedList = 'Hallmark genes';
  // bool isPathogenicSelected = true; // Checkbox padrão selecionado
  // bool isBenignSelected = true; // Checkbox padrão selecionado

  List<String> predefinedLists = [
    'All genes',
    'Hallmark genes',
    'DNA-rep genes',
    'Rep-rep genes',
  ];

  Future<void> _pickFile() async {
    // // FilePickerCross filePicker = FilePickerCross();
    // FilePickerCross filePicker = await FilePickerCross.pick(
    //     type: FileTypeCross
    //         .custom, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
    //     fileExtension:
    //         'txt' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
    //     );
    // if (filePicker != null && filePicker.path != null) {
    //   searchScreenBloc.geneList = File(filePicker.path);
    // }

    FilePickerCross.pick(fileExtension: 'txt')
        .then((filePicker) => setState(() {
              if (filePicker.path != null && filePicker.path != "") {
                searchScreenBloc.geneList = File(filePicker.path);
                searchScreenBloc.uploadedFileName = filePicker.path
                    .split("/")[filePicker.path.split("/").length - 1];
              }
              // _fileLength = filePicker.toUint8List().lengthInBytes;
              // try {
              //   _fileString = filePicker.toString();
              // } catch (e) {
              //   _fileString =
              //       'Not a text file. Showing base64.\n\n' + filePicker.toBase64();
              // }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Search Filters'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pathogenicity Filters:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
                'Machine Learning Score: ${searchScreenBloc.patogenicidadeMachineLearning.toStringAsFixed(1)}'),
            Slider(
              value: searchScreenBloc.patogenicidadeMachineLearning,
              onChanged: (newValue) {
                setState(() {
                  searchScreenBloc.patogenicidadeMachineLearning = newValue;
                });
              },
              min: 0,
              max: 15,
              divisions: 15,
              label: searchScreenBloc.patogenicidadeMachineLearning
                  .toStringAsFixed(1),
            ),
            SizedBox(height: 16),
            Text(
                'Prediction Score: ${searchScreenBloc.patogenicidadeTradicional.toStringAsFixed(1)}'),
            Slider(
              value: searchScreenBloc.patogenicidadeTradicional,
              onChanged: (newValue) {
                setState(() {
                  searchScreenBloc.patogenicidadeTradicional = newValue;
                });
              },
              min: 0,
              max: 21,
              divisions: 21,
              label:
                  searchScreenBloc.patogenicidadeTradicional.toStringAsFixed(1),
            ),
            SizedBox(height: 16),
            Text(
              'Select a Gene List:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: searchScreenBloc.selectedPredefinedList,
              onChanged: (String newValue) {
                setState(() {
                  searchScreenBloc.selectedPredefinedList = newValue;
                });
              },
              items: predefinedLists.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Arquivo: ' + searchScreenBloc.uploadedFileName,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickFile, // Usar a função _pickFile
                  child: Text('Upload Gene List'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Select Final Result:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            CheckboxListTile(
              title: Text('Pathogenic'),
              value: searchScreenBloc.isPathogenicSelected,
              onChanged: (value) {
                setState(() {
                  searchScreenBloc.isPathogenicSelected = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Benign'),
              value: searchScreenBloc.isBenignSelected,
              onChanged: (value) {
                setState(() {
                  searchScreenBloc.isBenignSelected = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Not Found'),
              value: searchScreenBloc.isNFSelected,
              onChanged: (value) {
                setState(() {
                  searchScreenBloc.isNFSelected = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
