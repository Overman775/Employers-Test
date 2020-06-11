import 'package:animated_background/animated_background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todolist/bloc/settings.dart';

import 'package:todolist/widgets/cover_line.dart';

import '../style.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  // get _isDarkMode = NeumorphicTheme.currentTheme(context) == ThemeMode.dark

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: NeumorphicBackground(
        child: Column(children: <Widget>[
          HeadDrawer(),
          ItemDrawer(
            icon: FontAwesomeIcons.language,
            text: 'settings.locale'.tr(),
            child: DropdownButton(
              value: context.locale,
              dropdownColor: NeumorphicTheme.baseColor(context),
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              items: <DropdownMenuItem<dynamic>>[
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('Engish'),
                ),
                DropdownMenuItem(
                  value: Locale('ru'),
                  child: Text('Русский'),
                )
              ],
              onChanged: (locale) {
                context.locale = locale;
              },
            ),
          ),
          ItemDrawer(
            icon: FontAwesomeIcons.moon,
            text: 'settings.dark_mode'.tr(),
            child: NeumorphicSwitch(
              value:  context.watch<Settings>().isDarkMode,
              onChanged: (dark) {
                if (dark) {
                  context.read<Settings>().themeMode = ThemeMode.dark;
                } else {
                  context.read<Settings>().themeMode = ThemeMode.light;
                }
              },
            ),
          ),
          Spacer(),
        ]),
      ),
    );
  }
}

class HeadDrawer extends StatefulWidget {
  const HeadDrawer({Key key}) : super(key: key);

  @override
  _HeadDrawerState createState() => _HeadDrawerState();
}

class _HeadDrawerState extends State<HeadDrawer> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: ClipRect(
        child: Stack(
          children: <Widget>[
            AnimatedBackground(
              behaviour: RandomParticleBehaviour(
                  options: ParticleOptions(
                      baseColor: NeumorphicTheme.accentColor(context),
                      spawnMinSpeed: 10.0,
                      spawnMaxSpeed: 15.0,
                      particleCount: 100)),
              vsync: this,
              child: Center(
                child: NeumorphicText('title'.tr(),
                    textStyle: NeumorphicTextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold)),
              ),
            ),
            CoverLine(
              height: 32,
            ),
            CoverLine(
              alignment: Alignment.bottomCenter,
              height: 32,
            )
          ],
        ),
      ),
    );
  }
}

class ItemDrawer extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback onTap;
  final String text;
  final Widget child;

  const ItemDrawer(
      {@required this.icon,
      @required this.text,
      this.onTap,
      this.child,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          FaIcon(icon, color: NeumorphicTheme.defaultTextColor(context)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Style.mainPadding),
            child: Text(
              text,
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
          ),
          Spacer(),
          if (child != null) child
        ],
      ),
      onTap: onTap,
    );
  }
}

/*
new DropdownButton<String>(
  items: <String>['A', 'B', 'C', 'D'].map((String value) {
    return new DropdownMenuItem<String>(
      value: value,
      child: new Text(value),
    );
  }).toList(),
  onChanged: (_) {},
)*/