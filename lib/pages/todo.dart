import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/data_models.dart';
import '../models/pages_arguments.dart';
import '../providers/todo.dart';
import '../router.dart';
import '../style.dart';
import '../widgets/cover_line.dart';
import '../widgets/detail_card.dart';
import '../widgets/empty.dart';
import '../widgets/neo_pop_up.dart';
import '../widgets/task_item.dart';
import 'add_bottom_shet.dart';

class TodoPage extends StatefulWidget {
  final MainPageArguments args;

  TodoPage(this.args, {Key key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  AnimationPageInjection animationPageInjection;

  _TodoPageState();

  ///check page transistion end
  bool get _transistionPageEnd =>
      animationPageInjection.animationPage.value == 1;

  @override
  void initState() {
    context.read<Todo>().getChildrens(widget.args.category.id);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //update animation injection
    animationPageInjection = AnimationPageInjection.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CategoryAppBar(args: widget.args),
        floatingActionButton: CategoryFAB(args: widget.args),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: NeumorphicTheme.baseColor(context),
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(Style.mainPadding,
                  Style.halfPadding, Style.mainPadding, Style.mainPadding),
              child: Selector<Todo, Worker>(
                selector: (BuildContext context, Todo todo) => todo.categoryes
                    .firstWhere(
                        (element) => element.id == widget.args.category.id,
                        orElse: () => null),
                shouldRebuild: (old_category, new_category) =>
                    old_category != new_category,
                builder: (context, category, _) {
                  if (category == null) {
                    //return empty container when category deletet
                    return const SizedBox.shrink();
                  }
                  return Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(width: Style.mainPadding),
                      // Expanded(child: HeroProgress(category: category)),
                      HeroTitle(category: category),
                      HeroSubTitle(category: category),
                      HeroDetail(category: category)
                    ],
                  );
                },
              ),
            ),
            ListBody(transistionPageEnd: _transistionPageEnd, widget: widget)
          ],
        ));
  }
}

class CategoryFAB extends StatelessWidget {
  const CategoryFAB({
    Key key,
    @required this.args,
  }) : super(key: key);

  final MainPageArguments args;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Style.primaryColor,
      elevation: 0,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            gradient: Style.addButtonGradient,
            shape: BoxShape.circle,
            boxShadow: Style.buttonGlow),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        modalBottomSheet(context, args.category);
      },
    );
  }
}

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CategoryAppBar({
    Key key,
    @required this.args,
  }) : super(key: key);

  final MainPageArguments args;

  Future onSelected(String selected, BuildContext context) async {
    final block = context.read<Todo>();
    switch (selected) {
      case 'edit':
        //fix double editing
        final category = block.categoryes
            .firstWhere((element) => element.id == args.category.id);
        await Navigator.pushNamed(context, '/category/edit',
            arguments:
                MainPageArguments(category: category, cardPosition: null));
        break;
      case 'delete':
        await block.deleteWorker(args.category);
        Navigator.of(context).pop();
        await block.getWorkers();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicAppBar(
      actions: <Widget>[
        NeumorphicPopupMenuButton(
          icon: Icon(FontAwesomeIcons.ellipsisV),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onSelected: (String selected) => onSelected(selected, context),
          itemBuilder: (_) => <PopupMenuItem<String>>[
            PopupMenuItem<String>(
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.edit),
                    const SizedBox(width: Style.halfPadding),
                    const Text('Edit'),
                  ],
                ),
                value: 'edit'),
            PopupMenuItem<String>(
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.trashAlt),
                    const SizedBox(width: Style.halfPadding),
                    const Text('Delete'),
                  ],
                ),
                value: 'delete'),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 16 * 2);
}

class ListBody extends StatelessWidget {
  const ListBody({
    Key key,
    @required bool transistionPageEnd,
    @required this.widget,
  })  : _transistionPageEnd = transistionPageEnd,
        super(key: key);

  final bool _transistionPageEnd;
  final TodoPage widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedOpacity(
        //show task list when page transistion end
        opacity: _transistionPageEnd ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: Builder(builder: (context) {
          //if page transistion not endede show empty widget
          //beter for perfomance
          if (!_transistionPageEnd) {
            return const SizedBox.shrink();
          }
          //Stack for cover begin and end ListView
          return Stack(
            children: <Widget>[
              Consumer<Todo>(builder: (context, todo, child) {
                if (todo.items.isNotEmpty) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 80),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            Style.mainPadding,
                            Style.halfPadding,
                            Style.mainPadding,
                            Style.mainPadding),
                        child: Column(
                          children: <Widget>[
                            ...todo.items.map((item) =>
                                ChildWidget(item, widget.args.category)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: Style.halfPadding,
                      ),
                    ],
                  );
                } else {
                  return const EmptyTodo();
                }
              }),
              //top cover gradient
              const CoverLine(),
              CoverLine(
                alignment: Alignment.bottomCenter,
              ),
              /*Container(
                  height: Style.mainPadding,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      NeumorphicTheme.baseColor(context),
                      NeumorphicTheme.baseColor(context).withOpacity(0)
                    ],
                  ))),
              //bottom cover gradient
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: Style.mainPadding,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        NeumorphicTheme.baseColor(context),
                        NeumorphicTheme.baseColor(context).withOpacity(0)
                      ],
                    ))),
              ),*/
            ],
          );
        }),
      ),
    );
  }
}
