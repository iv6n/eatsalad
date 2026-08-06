import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuSearchBar extends StatelessWidget {
  const MenuSearchBar({
    Key? key,
    required this.onChanged,
    this.trailing,
  }) : super(key: key);

  final ValueSetter<String> onChanged;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 3),
      child: Row(children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 50,
            child: TextField(
              key: const PageStorageKey('searchBar_textField'),
              style: GoogleFonts.roboto(),
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: trailing,
                hintText: 'search here',
                hintStyle: GoogleFonts.roboto(),
              ),
              onChanged: (onChanged),
            ),
          ),
        ),
        SizedBox(
          //height: 20,
          child: Card(
            elevation: 2.5,
            margin: const EdgeInsets.only(
              left: 6,
              right: 6,
            ),
            color: Colors.grey[50],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.favorite,
                  color: Colors.red[400],
                )),
          ),
        ),
      ]),
    );
  }
}
