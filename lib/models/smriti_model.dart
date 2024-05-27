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
  });

  @Id()
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime date;

  @Property(type: PropertyType.date)
  DateTime lastUpdated;

  String tag;
  String title;
  String body;
}
