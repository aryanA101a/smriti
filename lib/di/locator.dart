import 'package:get_it/get_it.dart';
import 'package:smriti/repository/auth_repository.dart';
import 'package:smriti/repository/smriti_repository.dart';
import 'package:smriti/services/auth_service.dart';
import 'package:smriti/services/cache_service.dart';
import 'package:smriti/services/firestore_service.dart';
import 'package:smriti/viewmodels/create_edit_viewmodel.dart';
import 'package:smriti/viewmodels/home_viewmodel.dart';
import 'package:smriti/viewmodels/login_viewmodel.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  var (smritiBox, authStatusBox) = await CacheService.initCache();

  locator.registerLazySingleton<CacheService>(
      () => CacheService(smritiBox, authStatusBox));

  locator.registerLazySingleton<AuthService>(() => AuthService());

  locator.registerLazySingleton<FirestoreService>(() => FirestoreService());

  locator.registerLazySingleton<SmritiRepository>(
      () => SmritiRepository(locator(), locator()));

  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepository(locator(), locator()));

  locator.registerLazySingleton<HomeViewModel>(
      () => HomeViewModel(locator(), locator()));

  locator.registerFactory<CreateEditViewModel>(
      () => CreateEditViewModel(locator()));

  locator.registerFactory<LoginViewModel>(() => LoginViewModel(locator()));
}
