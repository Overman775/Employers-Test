import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../models/data_models.dart';
import '../models/pages_arguments.dart';
import '../providers/todo.dart';
import '../router.dart';
import '../style.dart';
import '../widgets/cover_line.dart';
import '../widgets/save_button.dart';
import '../widgets/text_form_fiels.dart';

class AddWorker extends StatefulWidget {
  final MainPageArguments args;

  AddWorker(this.args, {Key key}) : super(key: key);

  @override
  _AddWorkerState createState() => _AddWorkerState();
}

class _AddWorkerState extends State<AddWorker> {
  String title = '';
  AnimationPageInjection animationPageInjection;
  Worker worker;
  final _formKey = GlobalKey<FormState>();

  bool get _argsHaveCategory => widget.args?.category != null;

  ///check page transistion end
  ///if editing then return true
  bool get _transistionPageEnd =>
      animationPageInjection?.animationPage?.value == 1 || _argsHaveCategory;

  Future saveCategory() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (_argsHaveCategory) {
        await context.read<Todo>().editWorker(widget.args.category, worker);
      } else {
        await context.read<Todo>().addWorker(worker);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    if (_argsHaveCategory) {
      worker = widget.args.category;
    } else {
      worker = Worker();
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //update animation injection
    animationPageInjection = AnimationPageInjection.of(context);

    super.didChangeDependencies();
  }

  String fieldValidator(dynamic value) {
    if (value == null) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        appBar: NeumorphicAppBar(
          title: _argsHaveCategory
              ? const Text('add_category.title_edit').tr()
              : const Text('add_category.title_add').tr(),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(
                Style.mainPadding, Style.halfPadding, Style.mainPadding, 0),
            child: AnimatedOpacity(
              ///run Opacity animation when page transistion end
              opacity: _transistionPageEnd ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Builder(builder: (context) {
                //if page transistion not end show empty widget
                if (!_transistionPageEnd) {
                  return const SizedBox.shrink();
                }
                return Form(
                  key: _formKey,
                  child: Stack(
                    children: <Widget>[
                      ListView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 16.0),
                          children: <Widget>[
                            NeumorphicTextFormDecorator(
                              label: 'add_category.surname'.tr(),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                initialValue: worker.surname,
                                validator: fieldValidator,
                                onSaved: (value) {
                                  worker = worker.copyWith(surname: value);
                                },
                              ),
                            ),
                            NeumorphicTextFormDecorator(
                              label: 'add_category.name'.tr(),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                initialValue: worker.name,
                                validator: fieldValidator,
                                onSaved: (value) {
                                  worker = worker.copyWith(name: value);
                                },
                              ),
                            ),
                            NeumorphicTextFormDecorator(
                              label: 'add_category.middle_name'.tr(),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                initialValue: worker.middleName,
                                validator: fieldValidator,
                                onSaved: (value) {
                                  worker = worker.copyWith(middleName: value);
                                },
                              ),
                            ),
                            NeumorphicTextFormDecorator(
                              label: 'add_category.date'.tr(),
                              child: DateTimeField(
                                format: DateFormat('dd.MM.yyyy'),
                                textInputAction: TextInputAction.next,
                                initialValue: worker.date,
                                //TODO: fix next focus
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                onShowPicker: (context, currentValue) {
                                  return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100));
                                },
                                onSaved: (value) {
                                  worker = worker.copyWith(date: value);
                                },
                                validator: fieldValidator,
                              ),
                            ),
                            NeumorphicTextFormDecorator(
                              label: 'add_category.position'.tr(),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                initialValue: worker.position,
                                validator: fieldValidator,
                                onSaved: (value) {
                                  worker = worker.copyWith(position: value);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Center(
                              child: NeumorphicSaveButton(
                                  canSave: true, onPressed: saveCategory),
                            )
                          ]),
                      const CoverLine(),
                      CoverLine(
                        alignment: Alignment.bottomCenter,
                      ),
                    ],
                  ),
                );
              }),
            )));
  }
}
