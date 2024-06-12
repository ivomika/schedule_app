import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/infrastructure/state/schedule_state.dart';

class FloatingAddButton extends StatelessWidget {
  final void Function(ScheduleState state) onTap;

  const FloatingAddButton({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleState>(builder: (context, state, child) {
      return FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorLight,
        onPressed: () => onTap(state),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(30.0)
            )
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    });
  }
}
