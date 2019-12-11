import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<DetailPageState>>{
      DetailPageAction.action: _onAction,
      DetailPageAction.updateTabState: _updateTabState
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
