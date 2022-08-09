import 'package:eatsalad/home/tabs/catalog/widgets/widgets.dart';
import 'package:eatsalad/home/tabs/catalog/catalog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class MenuBody extends StatelessWidget {
  const MenuBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SearchBar(
          onChanged: (term) {
            context.read<SearchBloc>().add(SearchTermChanged(term));
          },
        ),
        const Expanded(child: _SearchContent())
      ],
    );
  }
}

class _SearchContent extends StatelessWidget {
  const _SearchContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SearchStatus.failure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('oops try again!')),
            );
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case SearchStatus.loading:
            return const _SearchLoading();
          case SearchStatus.success:
            return const _SearchSuccess();
          default:
            return const _SearchInitial();
        }
      },
    );
  }
}

class _SearchLoading extends StatelessWidget {
  const _SearchLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        key: const PageStorageKey("search_loading_shimmer"),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: ListView.separated(
          itemBuilder: (context, index) => Container(
            height: 48.0,
            color: Colors.white,
          ),
          itemCount: 10,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        ),
      ),
    );
  }
}

class _SearchSuccess extends StatelessWidget {
  const _SearchSuccess({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchResults(
      onTap: (item) {
        print(item);
        //navigate to item
        //Navigator.of(context).push<void>(
        //SynonymsPage.route(word: suggestion.value),
        // );
      },
    );
  }
}

class _SearchInitial extends StatelessWidget {
  const _SearchInitial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(builder: (context, state) {
      final List<Item> items = state.items;
      final List<Category> categories = state.categories;
      return ScrollablePositionedListPage(categories: categories, items: items);
    });
  }
}
