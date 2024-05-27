import 'package:get_it/get_it.dart';
import 'package:smriti/repository/smriti_repository.dart';
import 'package:smriti/services/cache_service.dart';
import 'package:smriti/viewmodels/create_edit_viewmodel.dart';
import 'package:smriti/viewmodels/home_viewmodel.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  var smritiBox= await CacheService.initCache();

  locator.registerLazySingleton<CacheService>(
      () => CacheService(smritiBox));

  locator.registerLazySingleton<SmritiRepository>(
      () => SmritiRepository(locator()));

  locator.registerLazySingleton<HomeViewModel>(() => HomeViewModel(locator()));

  locator.registerFactory<CreateEditViewModel>(
      () => CreateEditViewModel(locator()));
}
