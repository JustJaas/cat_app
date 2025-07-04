part of 'cat_bloc.dart';

abstract class CatEvent extends Equatable {
  const CatEvent();
  @override
  List<Object> get props => [];
}

class LoadData extends CatEvent {
  const LoadData();
}

class SearchData extends CatEvent {
  final String text;
  const SearchData({required this.text});
}
