import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_recipe/models/tab_item.dart';

//TODO replace with your own action
enum DetailPageAction { action, tabCellTapped, updateTabState }

class DetailPageActionCreator {
  static Action onAction() {
    return const Action(DetailPageAction.action);
  }

  static Action tabCellTapped(TabItem d) {
    return Action(DetailPageAction.tabCellTapped, payload: d);
  }

  static Action updateTabState() {
    return Action(DetailPageAction.updateTabState);
  }
}
