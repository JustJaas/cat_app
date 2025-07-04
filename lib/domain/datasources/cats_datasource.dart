import 'package:cats_app/domain/entities/cat.dart';

abstract class CatsDatasource {
  Future<List<Cat>> getCats();
}
