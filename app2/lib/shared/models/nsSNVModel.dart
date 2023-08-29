import 'dart:convert';

class NsSNVModel {
  final String chr;
  final int pos;
  final String ref;
  final String alt;
  String identification;
  String vcf;

  NsSNVModel(
      {this.chr, this.pos, this.ref, this.alt, this.identification, this.vcf});

  Map<String, dynamic> toMap() {
    return {
      'chr': chr,
      'pos': pos,
      'ref': ref,
      'alt': alt,
      'identification': identification,
      'vcf': vcf,
    };
  }

  factory NsSNVModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NsSNVModel(
      chr: map['chr'],
      pos: map['pos'],
      ref: map['ref'],
      alt: map['alt'],
      identification: map['identification'],
      vcf: map['vcf'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NsSNVModel.fromJson(String source) =>
      NsSNVModel.fromMap(json.decode(source));
}
