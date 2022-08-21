import 'package:apps_flyer_test/constants.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initContainer() async {
  AppsFlyerOptions options = AppsFlyerOptions(
    afDevKey: afDevKey,
    appId: afAppId,
    showDebug: true,
  );
  sl.registerLazySingleton(() => AppsflyerSdk(options));
}
