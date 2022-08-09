import 'package:eatsalad/home/tabs/cart/bloc/cart_bloc.dart';
import 'package:eatsalad/home/tabs/catalog/models/item.dart';
import 'package:eatsalad/home/tabs/catalog/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///combo
class ComboCard extends StatelessWidget {
  ComboCard({
    Key? key,
    required this.img,
  }) : super(key: key);
  final List imgaesdd = [
    'https://cdn.needish.com/prod-boxfish/ddcc2a2f-2615-4d7a-b422-8ccca8092326-grpn/scale/900x600.jpg',
    'https://scontent.fhmo2-1.fna.fbcdn.net/v/t1.6435-9/108241109_984820881977033_2887106976913326595_n.jpg?_nc_cat=103&_nc_rgb565=1&ccb=1-3&_nc_sid=730e14&_nc_eui2=AeHAsxVQk63Yc1PQXqq5DkZ5V5MY-85BUMtXkxj7zkFQywGkjFlpMNBJnKSIDYLqX7Y&_nc_ohc=gChI6AVboy0AX8apE2d&tn=5YvsUCCHY3wLQUcy&_nc_ht=scontent.fhmo2-1.fna&oh=e4395f87a1460509ec0221ec5e205c17&oe=60EB8D21',
    'https://scontent.fhmo2-1.fna.fbcdn.net/v/t1.6435-9/107841650_984820858643702_6088148705132003093_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=730e14&_nc_eui2=AeFT62XacM6rJsQyWPfDjKKVzjo8KrlCsNLOOjwquUKw0mS4nDYq64CaJxh2r_LVRDM&_nc_ohc=lQtcEv3N_bkAX-erzhG&_nc_ht=scontent.fhmo2-1.fna&oh=7bc539229415ed0a9c5e96da69e1f996&oe=60EBE29A',
  ];

  final int img;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final hugeStyle =
        Theme.of(context).textTheme.headline1?.copyWith(fontSize: 20);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.5, vertical: 3),
      child: SizedBox(
        width: size.width * 0.55,
        //height: size.width * 0.62,
        child: Card(
          elevation: 2.5,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(imgaesdd[img]),
          ),
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 85.0,
      child: Card(
          elevation: 2.5,
          margin: const EdgeInsets.all(
            6,
          ),
          color: Colors.grey[50],
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return InkWell(
                onTap: () => context.read<CartBloc>().add(CartItemAdded(item)),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, top: 8, right: 10, bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(flex: 2, child: Image.network(item.imageUrl)),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(item.itemName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(
                                    child: Text(
                                      'Delicioso producto hecho con ingredientes frescos',
                                      style: TextStyle(fontSize: 10),
                                      overflow: TextOverflow.clip,
                                    ),
                                  )
                                ]),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    '\$${item.variants.price}',
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const AddButton()
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}

class SaladCard extends StatelessWidget {
  const SaladCard({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 3),
      child: SizedBox(
        width: 135,
        height: 180,
        child: Card(
          elevation: 2.5,
          color: Colors.grey[50],
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 3),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                                top: 12, left: 2, right: 2),
                            height: 78,
                            width: 78,
                            child: Image.network(
                              item.imageUrl,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                variant1(3),
                                variant2(5),
                                variant3(3),
                              ],
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    item.itemName,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 100,
                    child: Text(
                      'Arma tu ensalada para 1-2 personas',
                      style:
                          TextStyle(fontSize: 9, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '\$ ${item.variants.price}',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        const AddButton()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget variant1(int qty) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        const Text('1 ',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        CircleAvatar(
          radius: 12.5,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: .3, color: Colors.black54)),
            padding: const EdgeInsets.all(4.0),
            child: Image.asset('assets/chicken_icon.png'),
          ),
        ),
      ]),
    );
  }

  Widget variant2(int qty) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        const Text('3 ',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        CircleAvatar(
          radius: 12.5,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: .3, color: Colors.black54)),
            padding: const EdgeInsets.all(4.0),
            child: Image.asset('assets/ingredients_icon.png'),
          ),
        ),
      ]),
    );
  }

  Widget variant3(int qty) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        const Text('2 ',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        CircleAvatar(
          radius: 12.5,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: .3, color: Colors.black54)),
            padding: const EdgeInsets.all(4.0),
            child: Image.asset('assets/dressings_icon.png'),
          ),
        ),
      ]),
    );
  }
}
