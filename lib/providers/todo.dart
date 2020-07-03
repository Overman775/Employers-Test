import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../db/sqlite.dart';
import '../models/data_models.dart';

class Todo extends ChangeNotifier {
  Todo() {
    _init();
  }

  List<Child> items = [];
  List<Worker> categoryes = [];

  Future _init() async {
    await getWorkers();
  }

  Future getWorkers({bool notify = true}) async {
    var _results = await SQLiteProvider.db.customSelect('SELECT t.* ,'
        '(SELECT COUNT(*) FROM ${Child.table} i WHERE i.worker=t.id ) as childrens '
        'FROM ${Worker.table} t');
    categoryes = _results.map<Worker>((item) => Worker.fromMap(item)).toList();
    if (notify) {
      notifyListeners();
    }
  }

  Future addWorker(Worker category) async {
    await SQLiteProvider.db.insert(Worker.table, category);
    log('Worker added');
    await getWorkers();
  }

  Future editWorker(Worker old_category, Worker new_category) async {
    if (old_category != new_category) {
      await SQLiteProvider.db.update(Worker.table, new_category);
      log('Worker edited');
      await getWorkers();
    }
  }

  Future deleteWorker(Worker category) async {
    await SQLiteProvider.db.delete(Worker.table, category);
    await SQLiteProvider.db.delete(Child.table, category, where: 'worker = ?');
    log('Worker deleted ${category.name}');
  }

  Future getChildrens(int workerId, {bool notify = true}) async {
    var _results = await SQLiteProvider.db.select(Child.table,
        where: '"worker" = ?', whereArgs: <dynamic>[workerId]);
    items = _results.map<Child>(Child.fromMap).toList();
    if (notify) {
      notifyListeners();
    }
  }

  Future addChild(Child item) async {
    await SQLiteProvider.db.insert(Child.table, item);
    log('Child add ${item.name}');
    await getChildrens(item.worker);
  }

  void updateChild(Child item, {int index}) {
    //search item if index not set
    index ??= items.indexWhere((old_item) => old_item.id == item.id);
    //overvrite
    items[index] = item;
  }

  void updateWorker(Worker item, {int index}) {
    //search item if index not set
    index ??= categoryes.indexWhere((old_item) => old_item.id == item.id);
    //overvrite
    categoryes[index] = item;
  }

  Future deleteChild(Child item) async {
    await SQLiteProvider.db.delete(Child.table, item);
    await getChildrens(item.worker);
    log('Child deleted ${item.name}');
  }

  Future editChild(Child old_item, Child new_item) async {
    if (old_item != new_item) {
      await SQLiteProvider.db.update(Child.table, new_item);
      await getChildrens(new_item.worker);
      log('Child edited ${old_item.name}');
    }
  }
}
