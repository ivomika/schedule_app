import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/infrastructure/state/settings_state.dart';
import 'package:schedule_app/ui/base/color/color_interface.dart';
import 'package:schedule_app/ui/settings/settings_slider.dart';

class SettingsModal extends StatelessWidget {

  const SettingsModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  color: Colors.black54),
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
          const SizedBox(height: 60,)
        ],
      ),
    );
  }
}
