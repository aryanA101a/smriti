import 'package:objectbox/objectbox.dart';

@Entity()
class Smriti {
  Smriti({
    this.id = 0,
    required this.date,
    required this.lastUpdated,
    required this.tag,
    required this.title,
    required this.body,
    this.synced = false,
  });

  @Id(assignable: true)
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime date;

  @Property(type: PropertyType.date)
  DateTime lastUpdated;

  String tag;
  String title;
  String body;
  bool synced;

  SmritiDto toDto() {
    return SmritiDto(
      id: id,
      date: date,
      lastUpdated: lastUpdated,
      tag: tag,
      title: title,
      body: body,
    );
  }
}

class SmritiDto {
  SmritiDto({
    required this.id,
    required this.date,
    required this.lastUpdated,
    required this.tag,
    required this.title,
    required this.body,
  });

  int id;
  DateTime date;
  DateTime lastUpdated;
  String tag;
  String title;
  String body;

  Smriti toSmriti() {
    return Smriti(
      id: id,
      date: date,
      lastUpdated: lastUpdated,
      tag: tag,
      title: title,
      body: body,
      synced: true,
    );
  }

  static SmritiDto fromMap(Map<String, dynamic> map) {
    return SmritiDto(
      id: map['id'] ?? 0,
      date: DateTime.parse(map['date']),
      lastUpdated: DateTime.parse(map['lastUpdated']),
      tag: map['tag'],
      title: map['title'],
      body: map['body'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'tag': tag,
      'title': title,
      'body': body,
    };
  }
}
