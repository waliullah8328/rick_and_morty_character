import 'dart:convert';
import 'package:hive/hive.dart';

part 'home_model.g.dart';

/// ===================== JSON Parsing Helpers =====================
RickAndMortyCharacterModel rickAndMortyCharacterModelFromJson(String str) =>
    RickAndMortyCharacterModel.fromJson(json.decode(str));

String rickAndMortyCharacterModelToJson(RickAndMortyCharacterModel data) =>
    json.encode(data.toJson());

/// ===================== MAIN MODEL =====================
class RickAndMortyCharacterModel {
  final Info? info;
  final List<Result> results;

  RickAndMortyCharacterModel({this.info, required this.results});

  factory RickAndMortyCharacterModel.fromJson(Map<String, dynamic> json) =>
      RickAndMortyCharacterModel(
        info: json["info"] != null ? Info.fromJson(json["info"]) : null,
        results: json["results"] != null
            ? List<Result>.from(
            json["results"].map((x) => Result.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "info": info?.toJson(),
    "results": results.map((x) => x.toJson()).toList(),
  };
}

/// ===================== INFO =====================
class Info {
  final int? count;
  final int? pages;
  final String? next;
  final String? prev;

  Info({this.count, this.pages, this.next, this.prev});

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    count: json["count"],
    pages: json["pages"],
    next: json["next"],
    prev: json["prev"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "pages": pages,
    "next": next,
    "prev": prev,
  };
}

/// ===================== RESULT (Hive) =====================
@HiveType(typeId: 0)
class Result extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? status;
  @HiveField(3)
  final String? species;
  @HiveField(4)
  final String? type;
  @HiveField(5)
  final String? gender;
  @HiveField(6)
  final Location? origin;
  @HiveField(7)
  final Location? location;
  @HiveField(8)
  final String? image;
  @HiveField(9)
  final List<String> episode;
  @HiveField(10)
  final String? url;
  @HiveField(11)
  final DateTime? created;
  @HiveField(12)
  final bool isEdited;

  /// 🔥 Original JSON for reset
  @HiveField(13)
  final Map<String, dynamic>? originalJson;

  Result({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    required this.episode,
    this.url,
    this.created,
    this.isEdited = false,
    this.originalJson,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    species: json["species"],
    type: json["type"],
    gender: json["gender"],
    origin: json["origin"] != null
        ? Location.fromJson(Map<String, dynamic>.from(json["origin"]))
        : null,
    location: json["location"] != null
        ? Location.fromJson(Map<String, dynamic>.from(json["location"]))
        : null,
    image: json["image"],
    episode: json["episode"] != null
        ? List<String>.from(json["episode"])
        : [],
    url: json["url"],
    created:
    json["created"] != null ? DateTime.parse(json["created"]) : null,
    originalJson: json,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "species": species,
    "type": type,
    "gender": gender,
    "origin": origin?.toJson(),
    "location": location?.toJson(),
    "image": image,
    "episode": episode,
    "url": url,
    "created": created?.toIso8601String(),
  };

  Result copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    Location? origin,
    Location? location,
    String? image,
    List<String>? episode,
    String? url,
    DateTime? created,
    bool? isEdited,
    Map<String, dynamic>? originalJson,
  }) {
    return Result(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      location: location ?? this.location,
      image: image ?? this.image,
      episode: episode ?? this.episode,
      url: url ?? this.url,
      created: created ?? this.created,
      isEdited: isEdited ?? this.isEdited,
      originalJson: originalJson ?? this.originalJson,
    );
  }

  /// ================= RESET =================
  Result reset() {
    if (originalJson == null) return this;
    final Map<String, dynamic> map = _convertMap(originalJson!);
    return Result.fromJson(map);
  }

  /// Recursive map conversion to ensure Map<String,dynamic>
  Map<String, dynamic> _convertMap(Map<dynamic, dynamic> map) {
    return map.map((key, value) {
      if (value is Map) {
        return MapEntry(key.toString(), _convertMap(value.cast<dynamic, dynamic>()));
      } else if (value is List) {
        return MapEntry(key.toString(), value.map((e) {
          if (e is Map) {
            return _convertMap(e.cast<dynamic, dynamic>());
          }
          return e;
        }).toList());
      }
      return MapEntry(key.toString(), value);
    });
  }
}

/// ===================== LOCATION (Hive) =====================
@HiveType(typeId: 1)
class Location {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? url;

  Location({this.name, this.url});

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}