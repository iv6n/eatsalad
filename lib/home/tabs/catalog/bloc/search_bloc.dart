import 'package:bloc/bloc.dart';
import 'package:eatsalad/home/tabs/catalog/catalog.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.items}) : super(const SearchState.initial()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  final List<Item> items;

  void _onTextChanged(
    TextChanged event,
    Emitter<SearchState> emit,
  ) async {
    final searchTerm = event.text;

    if (searchTerm.isEmpty) return emit(const SearchState.initial());
    if (state.status == SearchStatus.loading) {
      const SearchState.loading();
    }

    const SearchState.loading();

    try {
      final results = items
          .map(
            (result) => Item(
                result.id.toString(),
                result.itemName.toString(),
                result.description.toString(),
                result.color.toString(),
                result.categoryId.toString(),
                result.imageUrl.toString(),
                result.variants),
          )
          .toList();
      final suggestions = List.of(
        results.where(
          (element) => element.itemName.startsWith(
            RegExp(event.text, caseSensitive: false),
          ),
        ),
      );

      emit(SearchState.success(suggestions));
    } catch (error) {
      emit(
        const SearchState.failure(),
      );
    }
  }
}

class SearchResultError {
  const SearchResultError({required this.message});

  final String message;

  static SearchResultError fromJson(dynamic json) {
    return SearchResultError(
      message: json['message'] as String,
    );
  }
}
