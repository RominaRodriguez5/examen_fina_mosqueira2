import 'dart:convert';

class NetPrecision {
  final int id;
  final String name;
  final String abbrev;
  final String description;

  NetPrecision({
    required this.id,
    required this.name,
    required this.abbrev,
    required this.description,
  });

  factory NetPrecision.fromJson(String str) =>
      NetPrecision.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NetPrecision.fromMap(Map<String, dynamic> json) => NetPrecision(
    id: json["id"],
    name: json["name"],
    abbrev: json["abbrev"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "abbrev": abbrev,
    "description": description,
  };
}

enum Type { LIST }

final typeValues = EnumValues({"list": Type.LIST});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
