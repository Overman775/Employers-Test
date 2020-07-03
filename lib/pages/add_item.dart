import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:emplist/models/data_models.dart';
import 'package:emplist/widgets/save_button.dart';
import 'package:emplist/widgets/text_form_fiels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../providers/todo.dart';
import '../models/pages_arguments.dart';
import '../style.dart';
import '../widgets/text_field.dart';

class AddChild extends StatefulWidget {
  final ItemPageArguments args;
  AddChild(this.args, {Key key}) : super(key: key);

  @override
  _AddChildState createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  Child children;
  final _formKey = GlobalKey<FormState>();

  Future saveItem() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      await context.read<Todo>().editChild(widget.args.item, children);
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
  void initState() {
    children = widget.args.item;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: NeumorphicAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Style.mainPadding),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              NeumorphicTextFormDecorator(
                label: 'add_category.surname'.tr(),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  initialValue: children.surname,
                  validator: fieldValidator,
                  onSaved: (value) {
                    children = children.copyWith(surname: value);
                  },
                ),
              ),
              NeumorphicTextFormDecorator(
                label: 'add_category.name'.tr(),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  initialValue: children.name,
                  validator: fieldValidator,
                  onSaved: (value) {
                    children = children.copyWith(name: value);
                  },
                ),
              ),
              NeumorphicTextFormDecorator(
                label: 'add_category.middle_name'.tr(),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  initialValue: children.middleName,
                  validator: fieldValidator,
                  onSaved: (value) {
                    children = children.copyWith(middleName: value);
                  },
                ),
              ),
              NeumorphicTextFormDecorator(
                label: 'add_category.date'.tr(),
                child: DateTimeField(
                  format: DateFormat('dd.MM.yyyy'),
                  textInputAction: TextInputAction.next,
                  initialValue: children.date,
                  //TODO: fix next focus
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
              Center(
                child: NeumorphicSaveButton(canSave: true, onPressed: saveItem),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
