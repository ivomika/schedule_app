import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/infrastructure/state/settings_state.dart';
import 'package:schedule_app/ui/base/text/body.dart';
import 'package:schedule_app/ui/base/text/caption.dart';
import 'package:schedule_app/ui/settings/settings_slider.dart';

class SettingsModal extends StatelessWidget {
  final String appName;
  final String version;

  const SettingsModal({
    super.key,
    required this.appName,
    required this.version,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          )
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 80,
              height: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: theme.colorScheme.onSurface
              ),
            ),
          ),
          const SizedBox(height: 16,),
          Consumer<SettingsState>(
            builder: (context, state, child) {
              return SettingsSlider(
                text: 'Использовать встроенное\nформатирование?',
                value: state.useFormatting,
                onChanged: (bool changedValue) =>
                    state.changeUseFormatting(changedValue),
              );
            }
          ),
          const SizedBox(height: 60,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BodyText(appName),
              const SizedBox(height: 4),
              CaptionText(
                  version,
                  color: Theme.of(context).hintColor,
              )
            ],
          ),
        ],
      ),
    );
  }
}
