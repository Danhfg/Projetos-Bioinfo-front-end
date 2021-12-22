import 'package:app2/shared/models/nsSNVGetModel.dart';

class PaginationNsSNVGETModel {
  List<NsSNVGETModel> content;
  Pageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  int size;
  int number;
  int numberOfElements;
  bool first;
  bool empty;

  PaginationNsSNVGETModel(
      {this.content,
      this.pageable,
      this.totalPages,
      this.totalElements,
      this.last,
      this.size,
      this.number,
      this.numberOfElements,
      this.first,
      this.empty});

  PaginationNsSNVGETModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = [];
      json['content'].forEach((v) {
        content.add(new NsSNVGETModel.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    size = json['size'];
    number = json['number'];
    numberOfElements = json['numberOfElements'];
    first = json['first'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['NsSNVGETModel'] = this.content.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['last'] = this.last;
    data['size'] = this.size;
    data['number'] = this.number;
    data['numberOfElements'] = this.numberOfElements;
    data['first'] = this.first;
    data['empty'] = this.empty;
    return data;
  }
}

class Pageable {
  Sort sort;
  int offset;
  int pageSize;
  int pageNumber;
  bool paged;
  bool unpaged;

  Pageable(
      {this.sort,
      this.offset,
      this.pageSize,
      this.pageNumber,
      this.paged,
      this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sort != null) {
      data['sort'] = this.sort.toJson();
    }
    data['offset'] = this.offset;
    data['pageSize'] = this.pageSize;
    data['pageNumber'] = this.pageNumber;
    data['paged'] = this.paged;
    data['unpaged'] = this.unpaged;
    return data;
  }
}

class Sort {
  bool sorted;
  bool unsorted;
  bool empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sorted'] = this.sorted;
    data['unsorted'] = this.unsorted;
    data['empty'] = this.empty;
    return data;
  }
}
