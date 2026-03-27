import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../feature/home_section/home/model/home_model.dart';

final dioProvider = Provider((ref) {
  return Dio(BaseOptions(
    baseUrl: "https://rickandmortyapi.com/api/",
  ));
});

final apiProvider = Provider((ref) => ApiService(ref));

class ApiService {
  final Ref ref;
  ApiService(this.ref);

  Future<List<Result>> getCharacters(int page) async {
    final dio = ref.read(dioProvider);

    final res = await dio.get("character", queryParameters: {
      "page": page,
    });

    final data = res.data;

    return List<Result>.from(
      data['results'].map((x) => Result.fromJson(x)),
    );
  }
}