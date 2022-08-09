import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eatsalad/home/tabs/catalog/catalog.dart';
import 'package:rxdart/rxdart.dart';

import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.items) : super(const SearchState.initial());

  final List<Item> items;

  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events, transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap((transitionFn));
  }

  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is MenuStarted) {
      yield* _mapMenuStartedToState(event, state);
    }
    if (event is SearchTermChanged) {
      yield* _mapSearchTermChangedToState(event, state);
    }
  }

  Stream<SearchState> _mapMenuStartedToState(
    MenuStarted event,
    SearchState state,
  ) async* {
    if (state is MenuStarted) {
      try {
        yield SearchState.loaded(items);
      } on Exception {
        yield const SearchState.failure();
      }
    }
  }

  Stream<SearchState> _mapSearchTermChangedToState(
    SearchTermChanged event,
    SearchState state,
  ) async* {
    if (event.term.isEmpty) {
      yield const SearchState.initial();
      return;
    }

    if (state.status == SearchStatus.loading) {
      yield const SearchState.loading();
    }

    try {
      final results = items
          .map(
            (result) => Item(
                result.id.toString(),
                result.itemName.toString(),
                result.color.toString(),
                result.categoryId.toString(),
                result.imageUrl.toString(),
                result.variants),
          )
          .toList();
      final suggestions = List.of(
        results.where(
          (element) => element.itemName.startsWith(
            RegExp(event.term, caseSensitive: false),
          ),
        ),
      );
      yield SearchState.success(suggestions);
    } on Exception {
      yield const SearchState.failure();
    }
  }
}
