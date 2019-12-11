import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_recipe/views/detail_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<MainPageState> buildEffect() {
  return combineEffects(<Object, Effect<MainPageState>>{
    MainPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    MainPageAction.bottomPanelTapped: _bottomPanelTapped,
  });
}

void _onAction(Action action, Context<MainPageState> ctx) {}
void _onInit(Action action, Context<MainPageState> ctx) {
  final Object _ticker = ctx.stfState;
  ctx.state.pageAnimationController = AnimationController(
      vsync: _ticker, duration: Duration(milliseconds: 300));
}

void _bottomPanelTapped(Action action, Context<MainPageState> ctx) async {
  ctx.state.pageAnimationController.forward(from: 0.0);
  Navigator.of(ctx.context)
      .push(PageRouteBuilder(
          opaque: true,
          pageBuilder: (_, __, ___) {
            return DetailPage().buildPage(null);
          }))
      .then((d) {
    ctx.state.pageAnimationController.reverse();
  });
}
