import 'package:cats_app/domain/entities/cat.dart';

abstract class CatsRepository {
  Future<List<Cat>> getCats();
}
