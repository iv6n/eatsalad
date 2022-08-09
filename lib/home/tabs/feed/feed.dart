//Tab 5 - Profile and Settings
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static const String id = 'pag0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text('Account & Settings',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              )),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: Colors.grey[300],
                height: .45,
              )),
        ),
        body: Container());
  }
}
