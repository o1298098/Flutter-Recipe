import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_recipe/views/detail_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<MainPageState> buildEffect() {
  return combineEffects(<Object, Effect<MainPageState>>{
    MainPageAction.action: _onAction,
    MainPageAction.bottomPanelTapped: _bottomPanelTapped,
  });
}

void _onAction(Action action, Context<MainPageState> ctx) {}

void _bottomPanelTapped(Action action, Context<MainPageState> ctx) async {
  await Navigator.of(ctx.context)
      .push(PageRouteBuilder(pageBuilder: (_, __, ___) {
    return DetailPage().buildPage(null);
  }));
}
