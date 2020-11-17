import 'dart:convert';

import 'package:app/src/domain/entities/nsSNV.dart';

class NsSNVModel extends NsSNV {
  final String chr;
  final int pos;
  final String ref;
  final String alt;

  NsSNVModel({this.chr, this.pos, this.ref, this.alt});

  Map<String, dynamic> toMap() {
    return {
      'chr': chr,
      'pos': pos,
      'ref': ref,
      'alt': alt,
    };
  }

  factory NsSNVModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NsSNVModel(
      chr: map['chr'],
      pos: map['pos'],
      ref: map['ref'],
      alt: map['alt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NsSNVModel.fromJson(String source) =>
      NsSNVModel.fromMap(json.decode(source));
}
