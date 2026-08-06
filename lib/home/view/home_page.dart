import 'package:eatsalad/home/widgets/menufab.dart';
import 'package:eatsalad/home/tabs/tabs.dart';
import 'package:eatsalad/home/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static const String id = 'bottomnavigation';

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    // Supply the Loyverse API key at build/run time, e.g.:
    //   flutter run --dart-define=LOYVERSE_API_KEY=your_key
    // Never hardcode it here — this file is committed to version control.
    final MenuRepository menuRepository = MenuRepository(
      apiKey: const String.fromEnvironment('LOYVERSE_API_KEY'),
    );

    return RepositoryProvider.value(
      value: menuRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MenuCubit>(
              create: (context) =>
                  MenuCubit(context.read<MenuRepository>())..getMenu()),
          BlocProvider<CartBloc>(
            create: (_) => CartBloc()..add(CartStarted()),
          ),
        ],
        child: ChangeNotifierProvider<BottomNavigationBarProvider>(
            create: (BuildContext context) => BottomNavigationBarProvider(),
            child: HomeView()),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({
    Key? key,
  }) : super(key: key);
  final PageStorageBucket bucket = PageStorageBucket();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        bucket: bucket,
        child: currentTab[provider.currentIndex],
      ),
      bottomNavigationBar: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          BottomBar(scaffoldkey: _scaffoldKey, provider: provider),
          MenuFab(
            onPressed: () {
              provider.currentIndex = 2;
            },
          ),
        ],
      ),
      endDrawerEnableOpenDragGesture: false,
      endDrawer: const Drawer(child: Profile()),
    );
  }
}
