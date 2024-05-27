import 'package:objectbox/objectbox.dart';

@Entity()
class AuthStatus {
  @Id()
  int id = 0;
  String name;
  String email;

  AuthStatus({required this.name, required this.email});
}