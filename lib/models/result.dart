import 'dart:convert';

import 'package:examen_fina_mosqueira2/models/netPrecision.dart';

class Result {
  String id;
  String url;
  String slug;
  String name;
  NetPrecision status;
  DateTime lastUpdated;
  DateTime net;
  NetPrecision netPrecision;
  DateTime windowEnd;
  DateTime windowStart;
  String lspName;
  String mission;
  String missionType;
  String pad;
  String location;
  dynamic landing;
  dynamic landingSuccess;
  dynamic launcher;
  dynamic orbit;
  String image;
  dynamic infographic;
  Type type;

  Result({
    required this.id,
    required this.url,
    required this.slug,
    required this.name,
    required this.status,
    required this.lastUpdated,
    required this.net,
    required this.netPrecision,
    required this.windowEnd,
    required this.windowStart,
    required this.lspName,
    required this.mission,
    required this.missionType,
    required this.pad,
    required this.location,
    required this.landing,
    required this.landingSuccess,
    required this.launcher,
    required this.orbit,
    required this.image,
    required this.infographic,
    required this.type,
  });

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    id: json["id"],
    url: json["url"],
    slug: json["slug"],
    name: json["name"],
    status: NetPrecision.fromMap(json["status"]),
    lastUpdated: DateTime.parse(json["last_updated"]),
    net: DateTime.parse(json["net"]),
    netPrecision: NetPrecision.fromMap(json["net_precision"]),
    windowEnd: DateTime.parse(json["window_end"]),
    windowStart: DateTime.parse(json["window_start"]),
    lspName: json["lsp_name"],
    mission: json["mission"],
    missionType: json["mission_type"],
    pad: json["pad"],
    location: json["location"],
    landing: json["landing"],
    landingSuccess: json["landing_success"],
    launcher: json["launcher"],
    orbit: json["orbit"],
    image: json["image"],
    infographic: json["infographic"],
    type: typeValues.map[json["type"]]!,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "url": url,
    "slug": slug,
    "name": name,
    "status": status.toMap(),
    "last_updated": lastUpdated.toIso8601String(),
    "net": net.toIso8601String(),
    "net_precision": netPrecision.toMap(),
    "window_end": windowEnd.toIso8601String(),
    "window_start": windowStart.toIso8601String(),
    "lsp_name": lspName,
    "mission": mission,
    "mission_type": missionType,
    "pad": pad,
    "location": location,
    "landing": landing,
    "landing_success": landingSuccess,
    "launcher": launcher,
    "orbit": orbit,
    "image": image,
    "infographic": infographic,
    "type": typeValues.reverse[type],
  };
}
