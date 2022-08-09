part of 'search_bloc.dart';

enum SearchStatus { initial, loaded, loading, success, failure }

class SearchState extends Equatable {
  const SearchState._({
    this.status = SearchStatus.initial,
    this.items = const <Item>[],
    this.suggestions = const <Item>[],
  });

  const SearchState.initial() : this._();

  const SearchState.loaded(List<Item> items)
      : this._(status: SearchStatus.loaded, items: items);

  const SearchState.loading() : this._(status: SearchStatus.loading);

  const SearchState.success(List<Item> suggestions)
      : this._(status: SearchStatus.success, suggestions: suggestions);

  const SearchState.failure() : this._(status: SearchStatus.failure);

  final SearchStatus status;

  final List<Item> items;
  final List<Item> suggestions;
  @override
  List<Object?> get props => [status, suggestions, items];
}
