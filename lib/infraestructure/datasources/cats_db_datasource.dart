import 'package:cats_app/config/app_config.dart';
import 'package:cats_app/domain/datasources/cats_datasource.dart';
import 'package:cats_app/domain/entities/cat.dart';
import 'package:dio/dio.dart';

final config = AppConfig();

class CatsDbDatasource extends CatsDatasource {
  final dio = Dio(BaseOptions(baseUrl: config.baseUrl, headers: {
    'x-api-key': config.apiKey,
  }));

  @override
  Future<List<Cat>> getCats() async {
    try {
      final response = await dio.get('/v1/breeds');

      final List<dynamic> catDataList = response.data ?? [];

      final List<Cat> catsList = catDataList
          .map((json) => Cat.fromJson(json as Map<String, dynamic>))
          .toList();

      return catsList;
    } catch (e) {
      throw Exception();
    }
  }
}
