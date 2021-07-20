import 'package:json_annotation/json_annotation.dart';

import 'enum.dart';

part 'cast.g.dart';

@JsonSerializable()
class Cast {
  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.biography,
    this.alsoKnownAs,
    this.birthday,
    this.deathday,
    this.placeOfBirth,
    this.name,
  });

  bool adult;
  int gender;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'known_for_department')
  Department knownForDepartment;
  @JsonKey(name: 'original_name')
  String originalName;
  double popularity;
  @JsonKey(name: 'profile_path')
  String profilePath;
  @JsonKey(name: 'cast_id')
  int castId;
  String character;
  @JsonKey(name: 'credit_id')
  String creditId;
  int order;
  @JsonKey(name: 'biography')
  String biography;
  @JsonKey(name: 'also_known_as')
  List<String> alsoKnownAs;
  @JsonKey(name: 'birthday')
  String birthday;
  @JsonKey(name: 'deathday')
  String deathday;
  @JsonKey(name: 'place_of_birth')
  String placeOfBirth;
  @JsonKey(name: 'name')
  String name;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}
