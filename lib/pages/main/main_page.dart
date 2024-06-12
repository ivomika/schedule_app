import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:schedule_app/infrastructure/state/schedule_state.dart';
import 'package:schedule_app/pages/archive/archive_page.dart';
import 'package:schedule_app/pages/home/home_page.dart';
import 'package:schedule_app/pages/settings/settings_modal.dart';
import 'package:schedule_app/ui/base/text/body.dart';
import 'package:schedule_app/ui/base/text/header.dart';
import 'package:schedule_app/ui/layout/main_layout.dart';
import 'package:schedule_app/utils/debugger.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      onSettingsButtonTap: () => _onSettingsButtonTap(context),
      onFloatingButtonTap: (state) => _onFloatingTap(state, context),
      pages: const [
        MyHomePage(),
        ArchivePage()
      ],
    );
  }
}


extension MainPageCallBacks on MainPageState{

  void _onSettingsButtonTap(BuildContext context) async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String version = packageInfo.version;

      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return SettingsModal(
              appName: appName,
              version: version
            );
          }
      );
    });
  }

  void _onFloatingTap(ScheduleState state, BuildContext context) async {
    var json = await _pickAndParseJsonFile();
    if (json == null) {
      _showDialog(context);
      return;
    }

    if (state.loadScheduleFromJson(json)) {
      await state.saveToPrefs();
    } else {
      _showDialog(context);
    }
  }

  Future<Map<String, dynamic>?> _pickAndParseJsonFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        File file = File(filePath);
        String jsonString = await file.readAsString();
        Map<String, dynamic> jsonResponse = json.decode(jsonString);

        return jsonResponse;
      }
    } catch (e) {
      Debugger.log('Error picking or parsing file: $e');
    }
    return null;
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const HeaderText('Error'),
        content: const BodyText('Не удалось загрузить файл'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pop(); // dismisses only the dialog and returns nothing
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}