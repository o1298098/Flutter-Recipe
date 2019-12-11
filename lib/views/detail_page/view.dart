import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipe/models/card_info.dart';
import 'package:flutter_recipe/models/tab_item.dart';
import 'package:flutter_recipe/utils/adapt.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DetailPageState state, Dispatch dispatch, ViewService viewService) {
  final CurvedAnimation p = CurvedAnimation(
      parent: state.pageAnimationController, curve: Curves.ease);
  final double _cardHeight = Adapt.screenH() * 2 / 3;
  Widget _buildTabCell(TabItem d) {
    TextStyle selectStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Adapt.px(20),
        color: Colors.white);
    TextStyle unSelectStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: Adapt.px(20));
    return GestureDetector(
        onDoubleTap: () => Navigator.of(viewService.context).pop(),
        onTap: () => dispatch(DetailPageActionCreator.tabCellTapped(d)),
        child: Container(
            width: Adapt.px(220),
            height: Adapt.px(80),
            child: Center(
              child:
                  Text(d.name, style: d.selected ? selectStyle : unSelectStyle),
            )));
  }

  Widget _buildTabBar() {
    final CurvedAnimation _tarAnimated = CurvedAnimation(
        parent: state.pageAnimationController,
        curve: Interval(0, .5, curve: Curves.ease));
    Color _tabBgColor = Color(0xFFFFBB01);
    return SlideTransition(
        position: Tween(begin: Offset(0, -.2), end: Offset.zero)
            .animate(_tarAnimated),
        child: Stack(
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: (Adapt.screenW() - Adapt.px(660)) / 2),
                child: SlideTransition(
                  position: Tween(begin: Offset.zero, end: Offset(2, 0))
                      .animate(state.tabController),
                  child: Container(
                    width: Adapt.px(220),
                    height: Adapt.px(80),
                    decoration: BoxDecoration(
                        color: _tabBgColor,
                        boxShadow: [
                          BoxShadow(
                              color: _tabBgColor.withAlpha(150),
                              blurRadius: 10,
                              offset: Offset(0, 5))
                        ],
                        borderRadius: BorderRadius.circular(Adapt.px(40))),
                  ),
                )),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: state.tars.map(_buildTabCell).toList(),
            )),
          ],
        ));
  }

  Widget _buildCardBackGround() {
    double _startHeight = Adapt.px(980) - Adapt.padTopH();
    return AnimatedBuilder(
      animation: p,
      builder: (_, widget) {
        return Transform.translate(
            offset: Offset(0, _startHeight) * (1 - p.value),
            child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: Adapt.px(60), horizontal: Adapt.px(50) * p.value),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[400],
                        offset: Offset(10, 10),
                        spreadRadius: 4,
                        blurRadius: 25)
                  ],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(Adapt.px(50)),
                    child: Image.asset(
                      state.selectedCard.backGroundUrl,
                      width: Tween(begin: Adapt.screenW(), end: Adapt.px(560))
                          .animate(p)
                          .value,
                      height: _cardHeight,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ))));
      },
    );
  }

  Widget _buildDish() {
    final Tween<double> _size = Tween(begin: Adapt.px(350), end: Adapt.px(550));
    return AnimatedBuilder(
        animation: p,
        builder: (_, widget) {
          return Transform.translate(
              offset: Offset(Adapt.px(100), Adapt.px(310)) * (1 - p.value),
              child: Container(
                padding: EdgeInsets.only(bottom: Adapt.px(80)),
                height: _cardHeight,
                width: Adapt.screenW(),
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  state.selectedCard.dishUrl,
                  width: _size.animate(p).value,
                  height: _size.animate(p).value,
                ),
              ));
        });
  }

  Widget _buildCardInfo() {
    return FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: state.pageAnimationController,
            curve: Interval(.7, 1, curve: Curves.ease))),
        child: Container(
          width: Adapt.px(560),
          height: _cardHeight,
          margin: EdgeInsets.symmetric(
              horizontal: Adapt.px(40), vertical: Adapt.px(60)),
          padding: EdgeInsets.symmetric(
              vertical: Adapt.px(60), horizontal: Adapt.px(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: Adapt.px(480),
                    height: Adapt.px(250),
                    padding: EdgeInsets.all(Adapt.px(30)),
                    decoration: BoxDecoration(
                        color: Colors.white.withAlpha(80),
                        borderRadius: BorderRadius.circular(Adapt.px(25))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: Adapt.px(300),
                              child: Text.rich(
                                TextSpan(children: [
                                  TextSpan(text: state.selectedCard.name),
                                  TextSpan(
                                      text: state.selectedCard.subName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ]),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Adapt.px(40)),
                              ),
                            ),
                            Icon(
                              Icons.favorite_border,
                              size: Adapt.px(55),
                              color: Colors.white,
                            )
                          ],
                        ),
                        SizedBox(height: Adapt.px(20)),
                        Container(
                          height: Adapt.px(2),
                          width: Adapt.px(150),
                          color: Color(0xFFFFBB01),
                        ),
                        SizedBox(height: Adapt.px(20)),
                        Text(
                          state.selectedCard.description,
                          style: TextStyle(
                              color: Colors.white, fontSize: Adapt.px(18)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                state.selectedCard.cal,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Adapt.px(80),
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }

  Widget _buildCard() {
    return Stack(
      children: <Widget>[
        _buildCardBackGround(),
        _buildCardInfo(),
        _buildDish(),
      ],
    );
  }

  Widget _buildIngredientCell(IngredientItem d) {
    return Container(
      width: Adapt.px(150),
      height: Adapt.px(120),
      child: Column(
        children: <Widget>[
          Image.asset(
            d.icon,
            width: Adapt.px(75),
          ),
          SizedBox(height: Adapt.px(10)),
          Text(
            d.name,
            style: TextStyle(color: Colors.grey, fontSize: Adapt.px(22)),
          )
        ],
      ),
    );
  }

  Widget _buildIngredients() {
    return FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: state.pageAnimationController,
            curve: Interval(.5, .8, curve: Curves.ease))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: Adapt.px(60)),
                child: Text(
                  'Ingredients',
                  style: TextStyle(
                      fontSize: Adapt.px(30), fontWeight: FontWeight.w600),
                )),
            SizedBox(
              height: Adapt.px(20),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: state.selectedCard.ingredients
                    .map(_buildIngredientCell)
                    .toList()),
          ],
        ));
  }

  return Scaffold(
      body: Stack(children: <Widget>[
    Container(
      width: Adapt.px(350),
      color: Color(0xFFF2F9FC),
    ),
    SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTabBar(),
            _buildCard(),
            _buildIngredients(),
          ],
        ),
      ),
    )
  ]));
}
