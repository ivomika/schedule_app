import 'package:flutter/material.dart';
import 'package:schedule_app/ui/base/color/color_interface.dart';
import 'package:schedule_app/ui/base/text/base.dart';
import 'package:schedule_app/ui/base/text/body.dart';
import 'package:schedule_app/ui/base/text/header.dart';

class SettingsSlider extends StatelessWidget {
  final String text;
  final bool value;
  final void Function(bool changedValue) onChanged;

  const SettingsSlider({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BaseText(text),
        Switch(
            activeColor: ColorInterface.surface,
            activeTrackColor: ColorInterface.primaryAccent,
            value: value,
            onChanged: onChanged
        )
      ],
    );
  }
}
