import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MainPageAction { action, bottomPanelTapped }

class MainPageActionCreator {
  static Action onAction() {
    return const Action(MainPageAction.action);
  }

  static Action bottomPanelTapped() {
    return const Action(MainPageAction.bottomPanelTapped);
  }
}
