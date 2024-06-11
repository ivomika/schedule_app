import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schedule_app/utils/debugger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState with ChangeNotifier{
  late bool useFormatting;

  void init() {
    Debugger.log('$this - start init');
    useFormatting = true;
    addListener(() => saveToPrefs());
    Debugger.log('$this - end init');
  }

  Map<String, dynamic> toJson(){
    return {
      'useFormatting': useFormatting
    };
  }

  void loadSettings() async {
    Debugger.log('$this - start load');
    var json = await loadFromPrefs();

    if(json == null) {
      Debugger.log('$this - end error load');
      return;
    }

    useFormatting = json['useFormatting'];
    notifyListeners();
    Debugger.log('$this - end success load');
  }

  void saveSettings() async {
    await saveToPrefs();
    notifyListeners();
  }

  Future<void> saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(toJson());
      await prefs.setString('settings', jsonString);
      Debugger.log('Settings saved to SharedPreferences');
    } catch (e) {
      Debugger.log('Error saving data: $e');
    }
  }

  Future<Map<String, dynamic>?> loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('settings');

      if (jsonString != null) {
        final jsonResponse = json.decode(jsonString);
        return jsonResponse;
      }
    } catch (e) {
      Debugger.log('Error loading data: $e');
    }

    return null;
  }

  void changeUseFormatting(bool value){
    useFormatting = value;
    notifyListeners();
  }
}