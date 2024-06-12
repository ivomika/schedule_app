import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/infrastructure/state/schedule_state.dart';
import 'package:schedule_app/ui/base/text/header.dart';

class DefaultAppBar extends StatelessWidget {
  final bool forceElevated;
  final VoidCallback onSettingsButtonTap;

  const DefaultAppBar({
    super.key,
    required this.forceElevated,
    required this.onSettingsButtonTap
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      centerTitle: false,
      actions: [_SettingButton(onSettingsButtonTap: onSettingsButtonTap)],
      title: const _Title(),
      snap: true,
      floating: true,
      forceElevated: forceElevated,
    );
  }
}

class _SettingButton extends StatelessWidget {
  final VoidCallback onSettingsButtonTap;

  const _SettingButton({
    required this.onSettingsButtonTap
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onSettingsButtonTap,
        icon: Icon(
          Icons.settings,
          color: Theme.of(context).colorScheme.onSurface,
        )
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleState>(
      builder: (context, state, child) {
        return HeaderText(
          'Расписание ${state.title}',
          color: Theme.of(context).colorScheme.onSurface,
        );
      },
    );
  }
}


