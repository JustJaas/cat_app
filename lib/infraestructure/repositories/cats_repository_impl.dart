import 'package:cats_app/domain/datasources/cats_datasource.dart';
import 'package:cats_app/domain/entities/cat.dart';
import 'package:cats_app/domain/repositories/cats_repository.dart';
import 'package:cats_app/infraestructure/datasources/cats_db_datasource.dart';

class CatsRepositoryImpl extends CatsRepository {
  final CatsDatasource dataSource;

  CatsRepositoryImpl({CatsDatasource? dataSource})
      : dataSource = dataSource ?? CatsDbDatasource();

  @override
  Future<List<Cat>> getCats() {
    return dataSource.getCats();
  }
}
