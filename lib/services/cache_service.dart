import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smriti/models/smriti_model.dart';
import 'package:smriti/objectbox.g.dart';


class CacheService {
  late final Box<Smriti> _smritiBox;

  CacheService(this._smritiBox);

  static Future<Box<Smriti>> initCache() async {
    final docsDir = await getApplicationDocumentsDirectory();
    Store store = await openStore(directory: p.join(docsDir.path, "smritidb"));

    return store.box<Smriti>();
  }

  int put(Smriti smriti) {
    return _smritiBox.put(smriti);
  }

  List<Smriti> getAll() {
    return _smritiBox.getAll();
  }

  bool delete(int id) {
    return _smritiBox.remove(id);
  }

}
