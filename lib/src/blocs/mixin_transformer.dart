import 'dart:async';

import 'package:pomodoro/src/blocs/app_states.dart';

mixin AppStateTransformer {
  final transformer = StreamTransformer<AppState, AppState>.fromHandlers(
    handleData: (state, sink) {
      final sm = state.stateManager;
      final cdm = sm.countDownManager;
      if (state is InitialState) {
        cdm.reInit();
        sink.add(InitialState(sm));
      } else if (state is WorkingState) {
        cdm.start();
        sink.add(WorkingState(sm));
      } else if (state is WorkingPauseState) {
        cdm.stop();
        sink.add(WorkingPauseState(sm));
      }
    },
  );
}
