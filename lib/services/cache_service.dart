import 'dart:developer';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smriti/models/auth_status_model.dart';
import 'package:smriti/models/smriti_model.dart';
import 'package:smriti/objectbox.g.dart';

class CacheService {
  late final Box<Smriti> _smritiBox;
  late final Box<AuthStatus> _authStatusBox;

  CacheService(this._smritiBox, this._authStatusBox);

  static Future<(Box<Smriti>, Box<AuthStatus>)> initCache() async {
    final docsDir = await getApplicationDocumentsDirectory();
    Store store = await openStore(directory: p.join(docsDir.path, "smritidb"));

    return (store.box<Smriti>(), store.box<AuthStatus>());
  }

  int put(Smriti smriti) {
    return _smritiBox.put(smriti);
  }

  List<int> putAll(List<Smriti> smritis) {
    return _smritiBox.putMany(smritis);
  }

  List<Smriti> getAll() {
    return _smritiBox.getAll();
  }

  bool delete(int id) {
    return _smritiBox.remove(id);
  }

  void setAuthStatus(String name, String email) {
    _authStatusBox.put(AuthStatus(name: name, email: email));
  }

  AuthStatus? getAuthStatus() {
    return _authStatusBox.get(1);
  }

  void removeAuthStatus() {
    _authStatusBox.removeAll();
  }
}
