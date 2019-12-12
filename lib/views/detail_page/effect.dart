import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_recipe/models/tab_item.dart';
import 'action.dart';
import 'state.dart';

Effect<DetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<DetailPageState>>{
    DetailPageAction.action: _onAction,
    DetailPageAction.tabCellTapped: _tabCellTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<DetailPageState> ctx) {}

void _onInit(Action action, Context<DetailPageState> ctx) {
  final Object ticker = ctx.stfState;
  ctx.state.tabController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 300));
  ctx.state.pageAnimationController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 400));
  ctx.state.selectedController = AnimationController(
      vsync: ticker,
      duration: Duration(milliseconds: 800),
      reverseDuration: Duration(milliseconds: 800));
}

void _onBuild(Action action, Context<DetailPageState> ctx) {
  ctx.state.pageAnimationController.forward();
}

void _onDispose(Action action, Context<DetailPageState> ctx) {
  ctx.state.pageAnimationController?.dispose();
  ctx.state.tabController?.dispose();
  ctx.state.selectedController?.dispose();
}

void _tabCellTapped(Action action, Context<DetailPageState> ctx) {
  TabItem item = action.payload;
  if (item != null) if (!item.selected) {
    ctx.state.selectedController.forward();
    ctx.state.tabController.animateTo(item.index / 2,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
    ctx.state.tars.forEach((f) {
      f.selected = false;
    });
    item.selected = true;

    ctx.dispatch(DetailPageActionCreator.updateTabState());
  }
}
