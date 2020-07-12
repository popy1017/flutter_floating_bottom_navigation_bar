import 'package:floating_bottom_navigation_bar/src/floating_navbar_item.dart';
import 'package:flutter/material.dart';

typedef Widget ItemBuilder(BuildContext context, FloatingNavbarItem items);

class FloatingNavbar extends StatefulWidget {
  final List<FloatingNavbarItem> items;
  final int currentIndex;
  final void Function(int val) onTap;
  final Color selectedBackgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color backgroundColor;
  final double fontSize;
  final double iconSize;
  final double itemBorderRadius;
  final double borderRadius;
  final double elevation;
  final ItemBuilder itemBuilder;

  FloatingNavbar({
    Key key,
    @required this.items,
    @required this.currentIndex,
    @required this.onTap,
    ItemBuilder itemBuilder,
    this.backgroundColor = Colors.black,
    this.selectedBackgroundColor = Colors.white,
    this.selectedItemColor = Colors.black,
    this.iconSize = 24.0,
    this.fontSize = 11.0,
    this.borderRadius = 8,
    this.itemBorderRadius = 8,
    this.elevation = 0,
    this.unselectedItemColor = Colors.white,
  })  : assert(items.length > 1),
        assert(items.length <= 5),
        assert(currentIndex <= items.length),
        itemBuilder = itemBuilder ??
            _defaultItemBuilder(
              unselectedItemColor: unselectedItemColor,
              selectedItemColor: selectedItemColor,
              borderRadius: borderRadius,
              fontSize: fontSize,
              backgroundColor: backgroundColor,
              currentIndex: currentIndex,
              iconSize: iconSize,
              itemBorderRadius: itemBorderRadius,
              items: items,
              onTap: onTap,
              selectedBackgroundColor: selectedBackgroundColor,
            ),
        super(key: key);

  @override
  _FloatingNavbarState createState() => _FloatingNavbarState();
}

class _FloatingNavbarState extends State<FloatingNavbar> {
  List<FloatingNavbarItem> get items => widget.items;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: widget.elevation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              padding: EdgeInsets.only(bottom: 8, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: widget.backgroundColor,
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: items.map((f) {
                    return widget.itemBuilder(context, f);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

ItemBuilder _defaultItemBuilder({
  Function(int val) onTap,
  List<FloatingNavbarItem> items,
  int currentIndex,
  Color selectedBackgroundColor,
  Color selectedItemColor,
  Color unselectedItemColor,
  Color backgroundColor,
  double fontSize,
  double iconSize,
  double itemBorderRadius,
  double borderRadius,
}) {
  return (BuildContext context, FloatingNavbarItem item) => Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  color: currentIndex == items.indexOf(item)
                      ? selectedBackgroundColor
                      : backgroundColor,
                  borderRadius: BorderRadius.circular(itemBorderRadius)),
              child: InkWell(
                onTap: () {
                  onTap(items.indexOf(item));
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  //max-width for each item
                  //24 is the padding from left and right
                  width: MediaQuery.of(context).size.width *
                          (100 / (items.length * 100)) -
                      24,
                  padding: EdgeInsets.all(4),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[item.icon, item.title],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
