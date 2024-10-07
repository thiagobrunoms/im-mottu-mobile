import 'package:common/common.dart';
import 'package:persistence/persistence.dart';
import 'package:get/get.dart';

class AppLifecycleService extends GetxService {
  late final AppLifecycleHandler _appLifecycleHandler;

  @override
  void onInit() {
    super.onInit();

    _appLifecycleHandler = AppLifecycleHandler(
      onAppClosing: _handleAppClosing,
    );

    _appLifecycleHandler.startObserving();
  }

  @override
  void onClose() {
    _appLifecycleHandler.stopObserving();
    super.onClose();
  }

  void _handleAppClosing() {
    print('App is closing - removing cache...');
    final persistence = Get.find<KeyValuePersistence>();
    persistence.deleteAll();
  }
}
