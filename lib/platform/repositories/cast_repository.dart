import 'package:flutter/material.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/services/api/api.dart';

class CastRepository {
  final Api api;

  CastRepository({@required this.api});

  Future<Cast> getCastDetail(int id) => api.getCastDetail(id);
}
