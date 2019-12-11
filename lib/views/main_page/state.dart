import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class MainPageState implements Cloneable<MainPageState> {
  AnimationController pageAnimationController;
  @override
  MainPageState clone() {
    return MainPageState()..pageAnimationController = pageAnimationController;
  }
}

MainPageState initState(Map<String, dynamic> args) {
  return MainPageState();
}
