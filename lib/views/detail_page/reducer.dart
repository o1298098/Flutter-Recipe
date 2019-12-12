import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_recipe/models/card_info.dart';

import 'action.dart';
import 'state.dart';

Reducer<DetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<DetailPageState>>{
      DetailPageAction.action: _onAction,
      DetailPageAction.updateTabState: _updateTabState,
      DetailPageAction.selectedCardChanged: _selectedCardChanged
    },
  );
}

DetailPageState _onAction(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();
  return newState;
}

DetailPageState _updateTabState(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();
  newState.tars = state.tars;
  return newState;
}

DetailPageState _selectedCardChanged(DetailPageState state, Action action) {
  final CardInfo _card = action.payload;
  final DetailPageState newState = state.clone();
  newState.selectedCard = _card;
  return newState;
}
