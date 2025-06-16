import 'dart:convert';

import 'package:examen_fina_mosqueira2/models/result.dart';

class Lanzamiento {
  int count;
  String next;
  dynamic previous;
  List<Result> results;

  Lanzamiento({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory Lanzamiento.fromJson(String str) =>
      Lanzamiento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Lanzamiento.fromMap(Map<String, dynamic> json) => Lanzamiento(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toMap())),
  };
}
