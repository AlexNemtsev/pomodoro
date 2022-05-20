import 'dart:async';

import 'package:pomodoro/src/blocs/countdown_manager.dart';

import 'app_states.dart';



class StateManager {
  late AppState _state;
  final _countDownManager = CountDownManager();

  final _controller = StreamController<AppState>.broadcast();
  late final Stream<AppState> _stateStream;

  Stream<AppState> get stream => _stateStream;
  AppState get state => _state;

  Stream<Time> get timeStream => _countDownManager.stream;
  Time get time => _countDownManager.state;

  StateManager() {
    // Возможно, это дело можно преобразовывать через transformer
    _stateStream = _controller.stream
        .asyncExpand<AppState>(_mapEventToState)
        .asBroadcastStream();
    _stateStream.listen((event) {});
    // TODO: Сделать перехватчик на основе этого кода
    timeStream.listen((event) { 
      if (event == Time.fromSeconds(0)) {
        // add(BreakingPauseState(this));
        print('timer is finished');
        // _countDownManager.start();
        // _countDownManager.reInit();
        add(BreakingPauseState(this));
      }
    });
    add(InitialState(this));
  }

  void add(AppState state) {
    _controller.add(state);
    _state = state;
  }

  Stream<AppState> _mapEventToState(AppState event) async* {
    // TODO: Добавить обработку событий перерыва
    if (event is InitialState) {
      _countDownManager.reInit();
      yield InitialState(this);
    } else if (event is WorkingState) {
      _countDownManager.start();
      yield WorkingState(this);
    } else if (event is WorkingPauseState) {
      _countDownManager.stop();
      yield WorkingPauseState(this);
    } else if (event is BreakingPauseState) {
      // Кнопка стоп в паузе перерыва не работает
      // кнопка пропуска вызывает ошибку: поле в CD не иницализировано
      // В зависимости от пред события нужно вызывать stop или reInit
      _countDownManager.reInit();
      yield BreakingPauseState(this);
    } else if (event is BreakingState) {
      _countDownManager.start();
      yield BreakingState(this);
    }
  }

  void close() {
    _controller.close();
    _countDownManager.close();
  }
}
