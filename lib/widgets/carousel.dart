import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../style.dart';

class Carousel extends StatelessWidget {
  const Carousel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: PageView.builder(        
          scrollDirection: Axis.horizontal,
          controller: PageController(initialPage: 0, viewportFraction: 0.8),
          itemBuilder: (context, index) => TaskCard()          
        ),
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(borderRadius: Style.mainBorderRadius),
      padding: EdgeInsets.all(18.0),
      margin: EdgeInsets.fromLTRB(0, Style.doublePadding, Style.doublePadding, Style.doublePadding),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: ()=>Navigator.pushNamed(context, '/list'),
      ),
    );
  }
}
