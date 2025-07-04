import 'package:bloc/bloc.dart';
import 'package:cats_app/domain/entities/cat.dart';
import 'package:cats_app/infraestructure/repositories/cats_repository_impl.dart';
import 'package:equatable/equatable.dart';

part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  CatBloc() : super(const CatState()) {
    on<LoadData>((event, emit) async {
      try {
        emit(CatState(isLoading: true));
        final response = await CatsRepositoryImpl().getCats();
        emit(CatState(cats: response, allCats: response, isLoading: false));
      } catch (e) {
        emit(CatState(isError: true));
      }
    });

    on<SearchData>((event, emit) {
      List<Cat> filterCats = state.allCats.where((value) {
        return value.name.toLowerCase().contains(event.text.toLowerCase());
      }).toList();

      if (event.text.isEmpty) {
        emit(state.copyWith(cats: state.allCats));
      } else {
        emit(state.copyWith(cats: filterCats));
      }
    });
  }
}
