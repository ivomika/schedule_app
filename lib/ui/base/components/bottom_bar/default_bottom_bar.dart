import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class DefaultBottomBar extends StatefulWidget {
  final void Function(int index) onChanged;
  final int currentIndex;

  const DefaultBottomBar({
    super.key,
    required this.onChanged,
    required this.currentIndex
  });

  @override
  State<DefaultBottomBar> createState() => _DefaultBottomBarState();
}

class _DefaultBottomBarState extends State<DefaultBottomBar> {
  late Map<String, IconData> _icons;

  @override
  void initState() {
    super.initState();
    _icons = {
      'Главная': Icons.home,
      'Aрхив': Icons.archive
    };
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return AnimatedBottomNavigationBar.builder(
      itemCount: 2,
      activeIndex: widget.currentIndex,
      tabBuilder: _iconBuilder,
      onTap: widget.onChanged,
      backgroundColor: theme.scaffoldBackgroundColor.lighten(2),
      gapLocation: GapLocation.center,
      splashRadius: 100,
      splashSpeedInMilliseconds: 200,
      splashColor: theme.primaryColor,
      elevation: 24,
    );
  }

  Widget _iconBuilder(int index, bool isActive) {
    var theme = Theme.of(context);
    var iconEntry = _icons.entries.elementAt(index);

    return Icon(
      iconEntry.value,
      color: isActive
          ? theme.primaryColorLight
          : theme.primaryColorDark,
    );
  }
}
