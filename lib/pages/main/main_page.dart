
import 'dart:convert';
import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/infrastructure/state/schedule_state.dart';
import 'package:schedule_app/pages/settings/settings_modal.dart';
import 'package:schedule_app/ui/base/color/color_interface.dart';
import 'package:schedule_app/ui/base/text/body.dart';
import 'package:schedule_app/ui/base/text/header.dart';
import 'package:schedule_app/ui/schedule/schedule_list_item.dart';
import 'package:schedule_app/utils/debugger.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorInterface.surface,
      body: SafeArea(
        child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: ColorInterface.surface,
                  surfaceTintColor: ColorInterface.surface,
                  centerTitle: false,
                  actions: [
                    IconButton(
                        onPressed: () => _onSettingsButtonTap(context),
                        icon: const Icon(Icons.settings)
                    )
                  ],
                  title: Consumer<ScheduleState>(
                    builder: (context, state, child) {
                      return HeaderText(
                        'Расписание ${state.title}',
                      );
                    },
                  ),
                  snap: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                ),
              ];
            },
            body: const _Body()
        ),
      ),
      floatingActionButton: const _FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const _BottomBar(),
    );
  }

  void _onSettingsButtonTap(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return const SettingsModal();
        }
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleState>(
      builder: (BuildContext context, ScheduleState state, Widget? child) {
        if (state.schedule.isEmpty) {
          return const Center(
            child: BodyText('Добавьте новое расписание'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: state.schedule.length,
          separatorBuilder: (_, __) => const SizedBox(
            height: 8,
          ),
          itemBuilder: (context, index) =>
              ScheduleListItem(
                sessionDay: state.schedule.elementAt(index),
              ),
        );
      },
    );
  }
}

class _FloatingButton extends StatelessWidget {
  const _FloatingButton();

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleState>(builder: (context, state, child) {
      return FloatingActionButton(
        elevation: 4,
        backgroundColor: ColorInterface.primaryAccent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(30.0)
            )
        ),
        onPressed: () => _onTap(state, context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    });
  }

  void _onTap(ScheduleState state, BuildContext context) async {
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

class _BottomBar extends StatefulWidget {
  const _BottomBar();

  @override
  State<_BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<_BottomBar> {
  late int _currentIndex;
  late List<IconData> _icons;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _icons = [Icons.home, Icons.info];
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBottomNavigationBar.builder(
      itemCount: 2,
      activeIndex: _currentIndex,
      backgroundColor: ColorInterface.surface,
      tabBuilder: (int index, bool isActive) {
        return Icon(
          _icons.elementAt(index),
          color: isActive
              ? ColorInterface.primaryAccent
              : Colors.black54,
        );
      },
      onTap: _onTap,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.defaultEdge,
      elevation: 8,
    );
  }

  _onTap(int index) {
    if(index == _icons.length - 1){
      _showInfo();
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  _showInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const HeaderText('О приложении'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BodyText(
                'Название - ${packageInfo.appName}'
            ),
            BodyText(
                'Версия - ${packageInfo.version}'
            ),
          ],
        ),
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