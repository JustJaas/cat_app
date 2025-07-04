part of 'cat_bloc.dart';

class CatState extends Equatable {
  final List<Cat> cats;
  final List<Cat> allCats;
  final bool isLoading;
  final bool isError;

  const CatState({
    this.cats = const [],
    this.allCats = const [],
    this.isLoading = false,
    this.isError = false,
  });

  CatState copyWith({
    List<Cat>? cats,
    List<Cat>? allCats,
    bool? isLoading,
    bool? isError,
  }) {
    return CatState(
      cats: cats ?? this.cats,
      allCats: allCats ?? this.allCats,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [cats, allCats, isLoading, isError];
}
