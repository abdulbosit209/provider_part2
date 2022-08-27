const String userNameTable = "user_name";


class CachedUserModelFields {
  static final List<String> values = [
    /// Add all fields
    name, age, count,
  ];
  static const String id = "_id";
  static const String name = "name";
  static const String age = "age";
  static const String count = "count";

}

class CachedUserModel {
  final int? id;
  final String name;
  final int age;
  final int count;

  CachedUserModel({this.id, required this.count, required this.name, required this.age});

  CachedUserModel copyWith({
    int? id,
  String? name,
  int? age,
    int? count,
}) => CachedUserModel(id: id ?? this.id, count: count ?? this.count, name: name ?? this.name, age: age ?? this.age);

  static CachedUserModel fromJson(Map<String, Object?> json) =>
      CachedUserModel(
        id: json[CachedUserModelFields.id] as int?,
        name: json[CachedUserModelFields.name] as String,
        age: json[CachedUserModelFields.age] as int,
        count: json[CachedUserModelFields.count] as int,
      );

  Map<String, Object?> toJson() => {
    CachedUserModelFields.id: id,
    CachedUserModelFields.name: name,
    CachedUserModelFields.age: age,
    CachedUserModelFields.count: count,
  };

  @override
  String toString() => '''
        age: $age 
        COUNT $count
        NAME $name
      ''';
}

/*
final String name;
  final int age;
  final int count;
 */