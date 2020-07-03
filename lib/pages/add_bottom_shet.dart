import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../models/data_models.dart';
import '../providers/todo.dart';
import '../style.dart';
import '../widgets/text_form_fiels.dart';

class AddChildBottomShet extends StatefulWidget {
  final Worker category;
  AddChildBottomShet({Key key, @required this.category}) : super(key: key);

  @override
  _AddChildBottomShetState createState() => _AddChildBottomShetState();
}

class _AddChildBottomShetState extends State<AddChildBottomShet> {
  Child children = Child();
  final _formKey = GlobalKey<FormState>();

  Future saveItem() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      children = children.copyWith(worker: widget.category.id);

      await context.read<Todo>().addChild(children);
      Navigator.of(context).pop();
    }
  }

  String fieldValidator(dynamic value) {
    if (value == null) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
      child: Container(
        height: 400,
        child: Neumorphic(
            padding: const EdgeInsets.all(Style.mainPadding),
            style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
                oppositeShadowLightSource: true),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  NeumorphicTextFormDecorator(
                    child: TextFormField(
                      decoration: InputDecoration.collapsed(
                          hintText: 'add_category.surname'.tr()),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                      validator: fieldValidator,
                      onSaved: (value) {
                        children = children.copyWith(surname: value);
                      },
                    ),
                  ),
                  NeumorphicTextFormDecorator(
                    child: TextFormField(
                      decoration: InputDecoration.collapsed(
                          hintText: 'add_category.name'.tr()),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                      validator: fieldValidator,
                      onSaved: (value) {
                        children = children.copyWith(name: value);
                      },
                    ),
                  ),
                  NeumorphicTextFormDecorator(
                    child: TextFormField(
                      decoration: InputDecoration.collapsed(
                          hintText: 'add_category.middle_name'.tr()),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                      validator: fieldValidator,
                      onSaved: (value) {
                        children = children.copyWith(middleName: value);
                      },
                    ),
                  ),
                  NeumorphicTextFormDecorator(
                    child: DateTimeField(
                      decoration: InputDecoration.collapsed(
                          hintText: 'add_category.date'.tr()),
                      format: DateFormat('dd.MM.yyyy'),
                      textInputAction: TextInputAction.next,
                      //TODO: fix next focus
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      onSaved: (value) {
                        children = children.copyWith(date: value);
                      },
                      validator: fieldValidator,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  NeumorphicButton(
                    padding: const EdgeInsets.all(16),
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            Style.mainBorderRadius)),
                    child: Text('save',
                            style: TextStyle(
                                color: NeumorphicTheme.accentColor(context)))
                        .tr(),
                    onPressed: saveItem,
                  )
                ],
              ),
            )),
      ),
    );
  }
}

void modalBottomSheet(BuildContext context, Worker category) {
  showModalBottomSheet<Widget>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) {
        return AddChildBottomShet(category: category);
      });
}
