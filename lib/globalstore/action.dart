import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';

enum GlobalAction { changeThemeColor, changeLocale, setUser }

class GlobalActionCreator {
  static Action onchangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }

  static Action changeLocale(Locale l) {
    return Action(GlobalAction.changeLocale, payload: l);
  }
}
