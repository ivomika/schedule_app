import 'package:flutter/material.dart';
import 'package:schedule_app/infrastructure/state/schedule_state.dart';
import 'package:schedule_app/ui/base/components/app_bar/default_app_bar.dart';
import 'package:schedule_app/ui/base/components/bottom_bar/default_bottom_bar.dart';
import 'package:schedule_app/ui/base/components/floating_action_button/floating_add_button.dart';

class MainLayout extends StatefulWidget {
  final VoidCallback onSettingsButtonTap;
  final void Function(ScheduleState state) onFloatingButtonTap;
  final List<Widget> pages;

  const MainLayout({
    super.key,
    required this.onSettingsButtonTap,
    required this.pages,
    required this.onFloatingButtonTap
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Theme.of(context).canvasColor,
    body: SafeArea(
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              DefaultAppBar(
                  forceElevated: innerBoxIsScrolled,
                  onSettingsButtonTap: widget.onSettingsButtonTap
              )
            ];
          },
          body: widget.pages.elementAt(_currentIndex)
      ),
    ),
    floatingActionButton: FloatingAddButton(onTap: widget.onFloatingButtonTap),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: DefaultBottomBar(
      onChanged: _onChange,
      currentIndex: _currentIndex,
    ),
    );
  }

  void _onChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
