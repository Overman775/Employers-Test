import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../models/data_models.dart';
import '../style.dart';

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
        category.surname,
        style: TextStyle(
            color: NeumorphicTheme.defaultTextColor(context), fontSize: 40.00),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class HeroSubTitle extends StatelessWidget {
  const HeroSubTitle({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Worker category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'subTitle_${category.id}',
      flightShuttleBuilder: flightShuttleBuilderFix,
      child: Text(
        '${category.name} ${category.middleName} ',
        style: TextStyle(color: Style.subTextColor, fontSize: 30.00),
        //softWrap: false,
        //overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class HeroDetail extends StatelessWidget {
  const HeroDetail({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Worker category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'position_${category.id}',
      flightShuttleBuilder: flightShuttleBuilderFix,
      child: Text(
        category.position,
        style: TextStyle(
            color: NeumorphicTheme.accentColor(context), fontSize: 30.00),
        //softWrap: false,
        //overflow: TextOverflow.ellipsis,
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
