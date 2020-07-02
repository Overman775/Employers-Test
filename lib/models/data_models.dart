abstract class DataModel {
  final int id;

  const DataModel({this.id});

  factory DataModel.fromMap() {
    return null;
  }
  Map<String, dynamic> toMap() {
    return null;
  }
}

class Worker extends DataModel {
  @override
  final int id;
  final String surname;
  final String name;
  final String middleName;
  final DateTime date;
  final String position;
  final int childrens;
  Worker(
      {this.id,
      this.surname,
      this.name,
      this.middleName,
      this.date,
      this.position,
      this.childrens});

  static const String table = 'Workers';

  Worker copyWith({
    int id,
    String surname,
    String name,
    String middleName,
    DateTime date,
    String position,
    int childrens,
  }) {
    return Worker(
      id: id ?? this.id,
      surname: surname ?? this.surname,
      name: name ?? this.name,
      middleName: middleName ?? this.middleName,
      date: date ?? this.date,
      position: position ?? this.position,
      childrens: childrens ?? this.childrens,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'surname': surname,
      'name': name,
      'middleName': middleName,
      'date': date?.toIso8601String(),
      'position': position,
      'childrens': childrens,
    };
  }

  factory Worker.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Worker(
      id: map['id'] as int,
      surname: map['surname'] as String,
      name: map['name'] as String,
      middleName: map['middleName'] as String,
      date: DateTime.parse(map['date'] as String),
      position: map['position'] as String,
      childrens: map['childrens'] as int,
    );
  }

  @override
  String toString() {
    return 'Worker(id: $id, surname: $surname, name: $name, middleName: $middleName, date: $date, position: $position, childrens: $childrens)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Worker &&
        o.id == id &&
        o.surname == surname &&
        o.name == name &&
        o.middleName == middleName &&
        o.date == date &&
        o.position == position &&
        o.childrens == childrens;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        surname.hashCode ^
        name.hashCode ^
        middleName.hashCode ^
        date.hashCode ^
        position.hashCode ^
        childrens.hashCode;
  }
}

class Child extends DataModel {
  @override
  final int id;
  final int worker;
  final String name;
  final String middleName;
  final DateTime date;
  Child({
    this.id,
    this.worker,
    this.name,
    this.middleName,
    this.date,
  });

  Child copyWith({
    int id,
    int worker,
    String name,
    String middleName,
    DateTime date,
  }) {
    return Child(
      id: id ?? this.id,
      worker: worker ?? this.worker,
      name: name ?? this.name,
      middleName: middleName ?? this.middleName,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'worker': worker,
      'name': name,
      'middleName': middleName,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  static Child fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Child(
      id: map['id'] as int,
      worker: map['worker'] as int,
      name: map['name'] as String,
      middleName: map['middleName'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }

  @override
  String toString() {
    return 'Child(id: $id, worker: $worker, name: $name, middleName: $middleName, date: $date)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Child &&
        o.id == id &&
        o.worker == worker &&
        o.name == name &&
        o.middleName == middleName &&
        o.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        worker.hashCode ^
        name.hashCode ^
        middleName.hashCode ^
        date.hashCode;
  }
}
