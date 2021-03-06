import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:flutter_uis/configs/AppDimensions.dart';
import 'package:flutter_uis/configs/App.dart';

import 'package:flutter_uis/widgets/Screen/Screen.dart';

import 'widgets/HFDHomeScreenRestaurantSlider.dart';
import 'widgets/HFDHomeScreenCategories.dart';
import 'widgets/HFDHomeScreenItemCard.dart';
import 'widgets/HFDHomeScreenFilters.dart';

import '../../../../configs/AppDimensions.dart';
import '../../configs/theme.dart' as theme;
import 'messages/keys.dart';
import 'data.dart' as data;
import 'Dimensions.dart';
import 'TestKeys.dart';

class HFDHomeScreen extends StatefulWidget {
  HFDHomeScreen({Key key}) : super(key: key);

  @override
  _HFDHomeScreenState createState() => _HFDHomeScreenState();
}

class _HFDHomeScreenState extends State<HFDHomeScreen> {
  int activeBottomNav = 0;

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions.init(context);

    return Container(
      child: Screen(
        theme: Theme.of(context).copyWith(
          accentColor: theme.primary,
          primaryColor: theme.primary,
        ),
        fontFamily: 'Nunito',
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: this.activeBottomNav,
          selectedItemColor: theme.primary,
          unselectedItemColor: Colors.black,
          onTap: (index) {
            setState(() {
              this.activeBottomNav = index;
            });
          },
          items: data.bottomNavList
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item),
                  title: Padding(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      width: 30,
                      height: 4,
                      transform: Matrix4.identity()..translate(0.0, 4.0),
                      decoration: BoxDecoration(
                        color: (data.bottomNavList[this.activeBottomNav] == item
                            ? theme.primary
                            : Colors.transparent),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        textStyle: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontFamily: 'Nunito'),
        child: SafeArea(
          top: false,
          child: ListView(
            key: Key(HFDHomeScreenTestKeys.rootScroll),
            children: <Widget>[
              // Header
              Padding(
                padding: EdgeInsets.all(AppDimensions.padding * 2),
                child: Row(
                  children: <Widget>[
                    Text(
                      App.translate(
                        HFDHomeScreenMessages.title,
                        context,
                      ),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Flexible(child: Container()),
                    InkWell(
                      onTap: () {},
                      child: Icon(MaterialIcons.search),
                    )
                  ],
                ),
              ),
              // Filter Bar
              HFDHomeScreenFilters(),
              // Build horizontal carousel slider
              Container(
                margin: EdgeInsets.only(
                  top: AppDimensions.padding * 4,
                  bottom: AppDimensions.padding * 4,
                ),
                // height: 340,
                height: Dimensions.itemBaseHeight,
                child: ListView.builder(
                  key: Key(HFDHomeScreenTestKeys.foodItemsScroll),
                  itemCount: data.items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    final item = data.items[index];

                    return HFDHomeScreenItemCard(
                      item,
                    );
                  },
                ),
              ),
              HFDHomeScreenCategories(),
              Container(
                padding: EdgeInsets.only(
                  top: AppDimensions.padding * 4,
                  left: AppDimensions.padding * 2,
                ),
                child: Text(
                  App.translate(
                    HFDHomeScreenMessages.topRestaurants,
                    context,
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              HFDHomeScreenRestaurantSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
