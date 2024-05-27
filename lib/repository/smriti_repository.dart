import 'package:smriti/models/smriti_model.dart';
import 'package:smriti/services/cache_service.dart';

class SmritiRepository {
  final CacheService _cacheDatabase;

  SmritiRepository(this._cacheDatabase);

  int save(Smriti smriti) {
    return _cacheDatabase.put(smriti);
  }

  List<Smriti> getAll() {
    return _cacheDatabase.getAll();
  }

  bool delete(int id) {
    return _cacheDatabase.delete(id);
  }
}
