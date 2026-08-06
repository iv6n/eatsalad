import 'package:eatsalad/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  static const String id = 'pag4';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_right),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_right_sharp),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Card(
                      elevation: 2,
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('Ivan Canizales',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  const Text('+55 (6621) 283-453',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300))
                ]),
          ),
          ListTile(
            title: const Text('My Orders'),
            leading: const Icon(Icons.receipt),
            onTap: () {},
          ),
          ListTile(
            title: const Text('My Profile'),
            leading: const Icon(Icons.account_circle),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Payment Method'),
            leading: const Icon(Icons.payment),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Delivery Address'),
            leading: const Icon(Icons.pin_drop_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Container()),
              );
            },
          ),
          ListTile(
            title: const Text('Settings'),
            leading: const Icon(Icons.settings),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Contact Us'),
            leading: const Icon(Icons.mail),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Help & FAQs'),
            leading: const Icon(Icons.help_outline),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Log Out'),
            leading: const Icon(Icons.logout),
            onTap: () {
              context.read<AppBloc>().add(const AppLogoutRequested());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
