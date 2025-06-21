import 'package:bloc_todo/api/controllers/auth.form.controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.store.dart';
import 'controllers/auth.controller.dart';
import 'http.client.dart';
import 'repositories/repository.dart';

Future<void> init() async {
  // load http client
  Get.lazyPut(() => HttpClient());

  var sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => AppStore(prefs: sharedPreferences));

  // load repositories
  Get.lazyPut(
    () => Repository(
      httpClient: Get.find<HttpClient>(),
      appStore: Get.find<AppStore>(),
    ),
  );

  //load controllers
  Get.put(
    () => AuthController(repository: Get.find<Repository>()),
    permanent: true,
  );

  Get.put(() => AuthFormController(), permanent: true);
}
