import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/infrastructure/state/schedule_state.dart';
import 'package:schedule_app/infrastructure/state/settings_state.dart';
import 'package:schedule_app/pages/main/main_page.dart';
import 'package:schedule_app/ui/base/color/color_interface.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: ColorInterface.surface, // цвет панели навигации
  ));

  ScheduleState createScheduleState(BuildContext context) {
    var schedule = ScheduleState();

    schedule.loadLocalSchedule();

    return schedule;
  }

  SettingsState createSettingsState(BuildContext context) {
    var settings = SettingsState();

    settings.init();
    settings.loadSettings();

    return settings;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsState>(create: createSettingsState),
        ChangeNotifierProvider<ScheduleState>(create: createScheduleState),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LearnTime',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorInterface.primary),
          useMaterial3: true,
        ),
        home: const MyHomePage());
  }
}
