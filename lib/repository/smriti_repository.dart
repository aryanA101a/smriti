import 'dart:async';
import 'package:smriti/models/smriti_model.dart';
import 'package:smriti/services/cache_service.dart';
import 'package:smriti/services/firestore_service.dart';

class SmritiRepository {
  final CacheService _cacheDatabase;
  final FirestoreService _firestoreService;

  SmritiRepository(this._cacheDatabase, this._firestoreService);

  Future<bool> save(Smriti smriti) async {
    _cacheDatabase.put(smriti);
    return await _firestoreService.saveSmriti(smriti.toDto());
  }

  Future<bool> getAll(StreamController<List<Smriti>> smritisController) async {
    smritisController.add(_cacheDatabase.getAll()); //return cache
    await syncOnline(); //sync
    List<Smriti>? smritis = (await _firestoreService.getAllSmritis())
        ?.map((e) => e.toSmriti())
        .toList(); //get fresh data
    if (smritis == null) return false;
    _cacheDatabase.putAll(smritis); //update cache
    smritisController.add(_cacheDatabase.getAll()); //return cache
    return true;
  }

  Future<void> syncOnline() async {
    var cache = _cacheDatabase.getAll();
    var updates = cache
        .where((element) => element.synced == false)
        .map((e) => e.toDto())
        .toList();
    await _firestoreService.saveSmritis(updates);
  }

  Future<bool> delete(int id) async {
    bool deleted = await _firestoreService.deleteSmriti(id);
    if (deleted) _cacheDatabase.delete(id);
    return deleted;
  }
}
