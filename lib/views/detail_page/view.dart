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
  final Color _baseColor = Color(0xFFFFBB01);
  final CurvedAnimation p = CurvedAnimation(
      parent: state.pageAnimationController, curve: Curves.ease);

  final double _cardHeight = Adapt.screenH() * 2 / 3;
  final double _recipeHeight = Adapt.padTopH() + Adapt.px(160);
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
        child: Material(
            color: Colors.transparent,
            child: Container(
                width: Adapt.px(220),
                height: Adapt.px(80),
                child: Center(
                  child: Text(d.name,
                      style: d.selected ? selectStyle : unSelectStyle),
                ))));
  }

  Widget _buildTabBar() {
    final CurvedAnimation _tarAnimated = CurvedAnimation(
        parent: state.pageAnimationController,
        curve: Interval(0, .5, curve: Curves.ease));
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
                        color: _baseColor,
                        boxShadow: [
                          BoxShadow(
                              color: _baseColor.withAlpha(150),
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
                padding: EdgeInsets.only(bottom: Adapt.px(60)),
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
          width: Adapt.px(580),
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
                            Text(state.selectedCard.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Adapt.px(40))),
                            Icon(
                              Icons.favorite_border,
                              size: Adapt.px(55),
                              color: Colors.white,
                            )
                          ],
                        ),
                        Text(state.selectedCard.subName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: Adapt.px(40))),
                        SizedBox(height: Adapt.px(20)),
                        Container(
                          height: Adapt.px(2),
                          width: Adapt.px(150),
                          color: _baseColor,
                        ),
                        SizedBox(height: Adapt.px(20)),
                        Text(
                          state.selectedCard.description,
                          maxLines: 2,
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
    final CurvedAnimation selectedAnimation = CurvedAnimation(
      parent: state.selectedController,
      curve: Interval(0.2, .9, curve: Curves.ease),
    );
    final CurvedAnimation dishAnimation = CurvedAnimation(
      parent: state.selectedController,
      curve: Interval(0.0, 1.0),
    );
    return SlideTransition(
        position: Tween(
                begin: Offset.zero,
                end: Offset(.85, _recipeHeight / Adapt.screenH()))
            .animate(selectedAnimation),
        child: Stack(
          children: <Widget>[
            _buildCardBackGround(),
            FadeTransition(
                opacity: Tween(begin: 1.0, end: 0.0).animate(selectedAnimation),
                child: _buildCardInfo()),
            SlideTransition(
                position: Tween(begin: Offset.zero, end: Offset(.85, 0.2))
                    .animate(dishAnimation),
                child: _buildDish()),
          ],
        ));
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
        opacity: Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: state.selectedController,
            curve: Interval(0.0, .1, curve: Curves.ease))),
        child: FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                parent: state.pageAnimationController,
                curve: Interval(.6, .8, curve: Curves.ease))),
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
            )));
  }

  Widget _buildSearchBar() {
    return FadeTransition(
        opacity: Tween(begin: 0.2, end: .9).animate(CurvedAnimation(
            parent: state.selectedController, curve: Curves.ease)),
        child: Container(
          height: Adapt.px(80),
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
          margin: EdgeInsets.only(
              top: Adapt.padTopH() + Adapt.px(160),
              left: Adapt.px(80),
              right: Adapt.px(80)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Adapt.px(40)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(5, 10),
                    blurRadius: 10),
              ]),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: Color(0xFFFFBB01),
              ),
              SizedBox(width: Adapt.px(30)),
              Text(
                'Search',
                style: TextStyle(color: Colors.grey, fontSize: Adapt.px(24)),
              )
            ],
          ),
        ));
  }

  Widget _buildRecipeCell(CardInfo d) {
    CurvedAnimation _dishAnimated = CurvedAnimation(
        parent: state.selectedController,
        curve: Interval(0.2, 0.5 + (4 - d.index) * 0.1, curve: Curves.ease));
    CurvedAnimation _infoAnimated = CurvedAnimation(
        parent: state.selectedController,
        curve: Interval((3 - d.index) * 0.2, 0.5 + (4 - d.index) * 0.1,
            curve: Curves.ease));
    return GestureDetector(
        onTap: () {
          dispatch(DetailPageActionCreator.selectedCardChanged(d));
          state.selectedController.reverse();
        },
        child: Container(
          margin: EdgeInsets.only(bottom: Adapt.px(60)),
          child: Row(
            children: <Widget>[
              SlideTransition(
                position: Tween(
                        begin: Offset(0, 1.0 * (6 - d.index)), end: Offset.zero)
                    .animate(_dishAnimated),
                child: Image.asset(d.dishUrl, width: Adapt.px(200)),
              ),
              SizedBox(width: Adapt.px(60)),
              FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(_infoAnimated),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${d.name} ${d.subName}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: Adapt.px(24)),
                      ),
                      SizedBox(height: Adapt.px(10)),
                      Text(
                        d.cal,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: Adapt.px(10)),
                      Container(
                        width: Adapt.px(100),
                        height: Adapt.px(40),
                        decoration: BoxDecoration(
                            border: Border.all(color: _baseColor),
                            borderRadius: BorderRadius.circular(Adapt.px(20))),
                        child: Center(
                          child: Text('Book',
                              style: TextStyle(
                                  color: _baseColor, fontSize: Adapt.px(20))),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }

  Widget _buildRecipeGroup() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          Adapt.px(50), _recipeHeight, Adapt.px(50), Adapt.px(50)),
      margin: EdgeInsets.only(top: Adapt.px(160)),
      child: Column(
        children: state.cards.map(_buildRecipeCell).toList(),
      ),
    );
  }

  return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: p,
        builder: (_, __) {
          return Container(
              color: Colors.white.withOpacity(p.value),
              child: Stack(children: <Widget>[
                Container(
                  width: Adapt.px(350),
                  color: Color(0xFFF2F9FC).withOpacity(p.value),
                ),
                _buildSearchBar(),
                _buildRecipeGroup(),
                SafeArea(
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: Adapt.px(30),
                      ),
                      _buildTabBar(),
                      _buildCard(),
                      _buildIngredients(),
                    ],
                  ),
                ),
              ]));
        },
      ));
}
