import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/data_models.dart';
import '../style.dart';
import 'animated_percent.dart';

class HeroProgress extends StatelessWidget {
  const HeroProgress({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Worker category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'progress_${category.id}',
      flightShuttleBuilder: flightShuttleBuilderFix,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'task_card',
            style: TextStyle(
                color:
                    NeumorphicTheme.defaultTextColor(context).withOpacity(0.5),
                fontSize: 16.00),
          ).plural(category.childrens),
          const SizedBox(
            height: Style.halfPadding,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: Style.mainPadding,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeroTitle extends StatelessWidget {
  const HeroTitle({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Worker category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'title_${category.id}',
      flightShuttleBuilder: flightShuttleBuilderFix,
      child: Text(
        category.name,
        style: TextStyle(
            color: NeumorphicTheme.defaultTextColor(context), fontSize: 40.00),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

Widget flightShuttleBuilderFix(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  ///fix overflow flex
  return SingleChildScrollView(
    //fix missed style
    child: DefaultTextStyle(
        style: DefaultTextStyle.of(fromHeroContext).style,
        child: fromHeroContext.widget),
  );
}
