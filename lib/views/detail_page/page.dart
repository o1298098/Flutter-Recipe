import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DetailPage extends Page<DetailPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  DetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DetailPageState>(
              adapter: null, slots: <String, Dependent<DetailPageState>>{}),
          middleware: <Middleware<DetailPageState>>[],
        );
}
