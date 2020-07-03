import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

import '../models/data_models.dart';
import '../models/pages_arguments.dart';
import '../providers/todo.dart';
import '../style.dart';

class ChildWidget extends StatelessWidget {
  final Child item;
  final Worker category;

  final DateFormat dateFormat = DateFormat('dd.MM.yyyy');

  ChildWidget(this.item, this.category, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: Style.halfPadding),
      style: NeumorphicStyle(
        depth: 3,
        intensity: 0.5,
        boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
      ),
      child: Dismissible(
        key: Key('item_${item.id}'),
        child: ListTile(
          title: Text('${item.surname} ${item.name} ${item.middleName}'),
          trailing: Text('${dateFormat.format(item.date)}'),
          //go to edit page
          onTap: () => unawaited(Navigator.pushNamed(context, '/item/edit',
              arguments: ItemPageArguments(item: item, category: category))),
        ),
        background: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Neumorphic(
            drawSurfaceAboveChild: false,
            padding: const EdgeInsets.only(left: Style.mainPadding),
            style: NeumorphicStyle(
              depth: -6,
              color: Style.editColor,
              lightSource: LightSource.topLeft,
              intensity: 1,
              boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FaIcon(
                FontAwesomeIcons.pen,
                color: Colors.white,
              ),
            ),
          ),
        ),
        secondaryBackground: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Neumorphic(
            drawSurfaceAboveChild: false,
            padding: const EdgeInsets.only(right: Style.mainPadding),
            style: NeumorphicStyle(
              depth: -6,
              color: Style.deleteColor,
              lightSource: LightSource.topRight,
              intensity: 1,
              boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: FaIcon(
                FontAwesomeIcons.trashAlt,
                color: Colors.white,
              ),
            ),
          ),
        ),
        confirmDismiss: (direction) {
          if (direction == DismissDirection.endToStart) {
            return Future.value(true);
          } else {
            unawaited(Navigator.pushNamed(context, '/item/edit',
                arguments: ItemPageArguments(item: item, category: category)));
            return Future.value(false);
          }
        },
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            context.read<Todo>().deleteChild(item);
          }
        },
      ),
    );
  }
}
