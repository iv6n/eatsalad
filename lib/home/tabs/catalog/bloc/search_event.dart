part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class MenuStarted extends SearchEvent {
  const MenuStarted();

  @override
  List<Object> get props => [];
}

class TextChanged extends SearchEvent {
  const TextChanged({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
  @override
  String toString() => 'TextChanged { text: $text }';
}
