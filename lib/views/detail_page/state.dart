import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipe/models/card_info.dart';
import 'package:flutter_recipe/models/tab_item.dart';

class DetailPageState implements Cloneable<DetailPageState> {
  List<TabItem> tars;
  AnimationController tabController;
  AnimationController pageAnimationController;
  AnimationController selectedController;
  List<CardInfo> cards;
  CardInfo selectedCard;
  @override
  DetailPageState clone() {
    return DetailPageState()
      ..cards = cards
      ..selectedCard = selectedCard
      ..tars = tars
      ..tabController = tabController
      ..selectedController = selectedController
      ..pageAnimationController = pageAnimationController;
  }
}

DetailPageState initState(Map<String, dynamic> args) {
  List<CardInfo> _cards = [
    CardInfo(
        0,
        'images/brooke_lark_bg.jpeg',
        'images/brooke_lark_dish.png',
        'Valley Farm',
        'Eggs',
        'Warm flour tortillas filled with crispy fried North Atlantic cod, fresh cabbage',
        '150cl', [
      IngredientItem('images/i_egg.png', 'Eggs'),
      IngredientItem('images/i_beef.png', 'Beef'),
      IngredientItem('images/i_onion.png', 'Onion'),
      IngredientItem('images/i_carrot.png', 'Carrot'),
    ]),
    CardInfo(
        1,
        'images/rocket_pesto_orzo_bg.png',
        'images/blackberries_dish.png',
        'Pie',
        'BlackBerries',
        'Beef tendon chips are ... turns to steam and the tendons puff up to form delicateld crisp',
        '120cl', [
      IngredientItem('images/i_orange.png', 'Orange'),
      IngredientItem('images/i_blackberries.png', 'Blackberries'),
      IngredientItem('images/i_cherry.png', 'Cherry'),
      IngredientItem('images/i_strawberry.png', 'Strawberry'),
    ]),
    CardInfo(
        2,
        'images/rocket_pesto_orzo_bg.png',
        'images/blackberries_dish.png',
        'Pie',
        'BlackBerries',
        'Beef tendon chips are ... turns to steam and the tendons puff up to form delicateld crisp',
        '120cl', [
      IngredientItem('images/i_orange.png', 'Orange'),
      IngredientItem('images/i_blackberries.png', 'Blackberries'),
      IngredientItem('images/i_cherry.png', 'Cherry'),
      IngredientItem('images/i_strawberry.png', 'Strawberry'),
    ]),
    CardInfo(
        3,
        'images/rocket_pesto_orzo_bg.png',
        'images/blackberries_dish.png',
        'Pie',
        'BlackBerries',
        'Beef tendon chips are ... turns to steam and the tendons puff up to form delicateld crisp',
        '120cl', [
      IngredientItem('images/i_orange.png', 'Orange'),
      IngredientItem('images/i_blackberries.png', 'Blackberries'),
      IngredientItem('images/i_cherry.png', 'Cherry'),
      IngredientItem('images/i_strawberry.png', 'Strawberry'),
    ]),
  ];
  return DetailPageState()
    ..tars = [
      TabItem(0, 'Breakfast', true),
      TabItem(1, 'Dinner', false),
      TabItem(2, 'Evening', false)
    ]
    ..cards = _cards
    ..selectedCard = _cards[0];
}
