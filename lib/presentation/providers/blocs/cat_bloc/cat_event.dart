part of 'cat_bloc.dart';

class CatEvent {}

class LoadData extends CatEvent {
  LoadData();
}

class SearchData extends CatEvent {
  final String text;
  SearchData({required this.text});
}

class ClearError extends CatEvent {
  ClearError();
}
