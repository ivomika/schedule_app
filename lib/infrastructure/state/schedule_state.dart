import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:schedule_app/infrastructure/object/session_day.dart';
import 'package:schedule_app/utils/debugger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleState with ChangeNotifier {
  late List<SessionDay> schedule;
  late String title;

  void loadLocalSchedule() async {
    Debugger.log('$this - start loadLocalSchedule');

    schedule = [];
    title = '---';

    var json = await loadFromPrefs();

    if(json != null){
      loadScheduleFromJson(json);
    }

    Debugger.log('$this - end loadLocalSchedule');
  }

  bool loadScheduleFromJson(Map<String, dynamic> json) {
    Debugger.log('$this - start loadScheduleFromJson');

    try{
      title = json['title'];
      schedule =
          (json['data'] as List).map((e) => SessionDay.fromJson(e)).toList();
      notifyListeners();
      Debugger.log('$this - end success loadScheduleFromJson');
      return true;
    }catch (e) {
      Debugger.log('Error load data: $e');
    }


    Debugger.log('$this - end error loadScheduleFromJson');
    return false;
  }

  Future<void> saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode({
        "title": title,
        "data": schedule.map((e) => e.toJson()).toList()
      });
      await prefs.setString('schedule', jsonString);
      Debugger.log('Data saved to SharedPreferences');
    } catch (e) {
      Debugger.log('Error saving data: $e');
    }
  }

  Future<Map<String, dynamic>?> loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('schedule');

      if (jsonString != null) {
        final jsonResponse = json.decode(jsonString);
        return jsonResponse;
      }
    } catch (e) {
      Debugger.log('Error loading data: $e');
    }

    return null;
  }
}
