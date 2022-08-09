import 'dart:math';

import 'package:eatsalad/home/tabs/catalog/catalog.dart';
import 'package:eatsalad/home/tabs/catalog/models/models.dart';
import 'package:eatsalad/home/tabs/catalog/widgets/image_slider.dart';
import 'package:eatsalad/home/tabs/catalog/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const scrollDuration = Duration(milliseconds: 1500);

///widget that uses [ScrollablePositionedList].
///
/// Shows a [ScrollablePositionedList] along with the following controls:
///   - Buttons to jump or scroll to certain items in the list.
///   - Slider to control the alignment of the items being scrolled or jumped
///   to.
///

class ScrollablePositionedListPage extends StatefulWidget {
  final List<Category> categories;
  final List<Item> items;
  const ScrollablePositionedListPage(
      {Key? key, required this.categories, required this.items})
      : super(key: key);
  callMethod(int value) => createState().scrollTo(value);

  @override
  _ScrollablePositionedListPageState createState() =>
      _ScrollablePositionedListPageState();
}

class _ScrollablePositionedListPageState
    extends State<ScrollablePositionedListPage> {
  /// Controller to scroll or jump to a particular item.
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final ItemScrollController itemScrollController2 = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener2 =
      ItemPositionsListener.create();

  bool reversed = false;
  final ValueNotifier<double> notifier = ValueNotifier(0);
  double heights = 275;

  /// The alignment to be used next time the user scrolls or jumps to an item.
  double alignment = 0;

  double current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
        positionsView,
        SizedBox(height: 60, child: list2(widget.categories)),
        Expanded(
          child: SizedBox(child: list(widget.categories, widget.items)),
        ),
      ]);
  Widget get positionsView => ValueListenableBuilder<Iterable<ItemPosition>>(
        valueListenable: itemPositionsListener.itemPositions,
        builder: (context, positions, child) {
          double min;

          if (positions.isNotEmpty) {
            // Determine the first visible item by finding the item with the
            // smallest trailing edge that is greater than 0.  i.e. the first
            // item whose trailing edge in visible in the viewport.
            min = positions
                .where((ItemPosition position) => position.itemTrailingEdge > 0)
                .reduce((ItemPosition min, ItemPosition position) =>
                    position.itemTrailingEdge < min.itemTrailingEdge
                        ? position
                        : min)
                .index
                .toDouble();
            print(min);

            if (min != current) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                //setState(() => current = min);
                //scrollTo2(min.toInt());
              });
            }
          }
          return Container();
        },
      );
//boxheight >= 0 ? boxheight : 0,
  Widget get alignmentControl => Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Text('Alignment: '),
          SizedBox(
            width: 200,
            child: Slider(
              value: alignment,
              onChanged: (double value) => setState(() => alignment = value),
            ),
          ),
        ],
      );
  Widget list2(List<Category?>? categories) => ScrollablePositionedList.builder(
        itemScrollController: itemScrollController2,
        itemPositionsListener: itemPositionsListener2,
        scrollDirection: Axis.horizontal,
        reverse: reversed,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) =>
            scrollButton(index, widget.categories[index].name),
      );
  Widget list(List<Category?>? categories, List<Item?>? items) =>
      ScrollablePositionedList.builder(
        initialAlignment: 0,
        initialScrollIndex: 0,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        reverse: reversed,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) =>
            item(index, widget.categories, widget.items),
      );
  Widget item(
    int i,
    List<Category> categories,
    List<Item> items,
  ) {
    return MenuItem(
      i: i,
      categories: categories,
      items: items,
    );
  }

  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: scrollDuration,
      curve: Curves.easeInOutCubic,
      alignment: alignment);
  void scrollTo2(int index) => itemScrollController2.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOutCubic,
      alignment: alignment);

  Widget scrollControlButtons(List<Category?>? category) =>
      SingleChildScrollView(
        key: const PageStorageKey("ScrollCategoriesTab"),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(widget.categories.length,
              (index) => scrollButton(index, category![index]!.name)),
        ),
      );

  Widget scrollButton(
    int value,
    String name,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 5,
      ),
      child: GestureDetector(
        onTap: () {
          scrollTo(value);
          scrollTo2(value);
          setState(() {
            current = value.toDouble();
          });
        },
        child: SizedBox(
          width: 128,
          child: Opacity(
            opacity: value == current ? 1 : .6,
            child: Card(
              elevation: value == current ? 5 : .5,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Image.asset('assets/ensalada.png'),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    child: Center(
                      child: Text(
                        name,
                        style: TextStyle(
                            fontSize: value == current ? 13 : 12.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[850]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.i,
    required this.categories,
    required this.items,
  }) : super(key: key);

  final int i;
  final List<Category> categories;
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    String? cat = categories[i].id;
    String? value = categories[i].name;
    return SizedBox(
      child: Column(children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
            //category
            child: Text(
              '$value ',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
        //items
        Column(
          children: [
            if (i == 0) ...[
              SingleChildScrollView(
                key: const PageStorageKey('ComboKey#'),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (Item item in items)
                      (item.categoryId == cat)
                          ? ComboCard(img: 0)
                          : Container(),
                  ],
                ),
              )
            ] else if (i == 1) ...[
              SingleChildScrollView(
                key: const PageStorageKey('SaladKey#'),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (Item item in items)
                      item.categoryId == cat
                          ? SaladCard(item: item)
                          : Container(),
                  ],
                ),
              )
            ] else ...[
              for (Item item in items)
                item.categoryId == cat ? ItemCard(item: item) : Container(),
            ],
          ],
        ),
      ]),
    );
  }
}

class HideableWidget extends StatelessWidget {
  final double height;
  final ValueNotifier<double> notifier;

  const HideableWidget({required this.height, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Transform.translate(
          offset: const Offset(0, 0),
          child: Container(
              height: height - value * 1 <= 0 ? 0 : height - value,
              color: Colors.red),
        );
      },
    );
  }
}
