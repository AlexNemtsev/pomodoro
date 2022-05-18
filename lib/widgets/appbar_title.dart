import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../src/blocs/app_states.dart';
import '../src/blocs/state_manager.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sm = context.read<StateManager>();
    return StreamBuilder<AppState>(
      stream: sm.stream,
      initialData: sm.state,
      builder: (context, snapshot) {
        final title = snapshot.data!.title;
        return Text(title);
      },
    );
  }
}
