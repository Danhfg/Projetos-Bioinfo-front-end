class NsSNVGETModel {
  int idNsSNV;
  String chr;
  int pos;
  String ref;
  String alt;
  String aaref;
  String aaalt;
  String result;
  bool alive;
  String identification;
  String resultML;

  NsSNVGETModel({
    this.idNsSNV,
    this.chr,
    this.pos,
    this.ref,
    this.alt,
    this.aaref,
    this.aaalt,
    this.result,
    this.alive,
    this.identification,
    this.resultML,
  });

  NsSNVGETModel.fromJson(Map<String, dynamic> json) {
    idNsSNV = json['idNsSNV'];
    chr = json['chr'];
    pos = json['pos'];
    ref = json['ref'];
    alt = json['alt'];
    aaref = json['aaref'];
    aaalt = json['aaalt'];
    result = json['result'];
    alive = json['alive'];
    identification = json['identification'];
    resultML = json['resultML'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idNsSNV'] = this.idNsSNV;
    data['chr'] = this.chr;
    data['pos'] = this.pos;
    data['ref'] = this.ref;
    data['alt'] = this.alt;
    data['aaref'] = this.aaref;
    data['aaalt'] = this.aaalt;
    data['result'] = this.result;
    data['alive'] = this.alive;
    data['identification'] = this.identification;
    data['resultML'] = this.resultML;
    return data;
  }
}
