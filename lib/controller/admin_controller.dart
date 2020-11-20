import 'package:get/state_manager.dart';
import 'package:prosiddho/model/admin_settings/admin_settings.dart';

class AdminController extends GetxController {
  Rx<AdminSettings> _adminSettings = AdminSettings.init().obs;

  AdminSettings get adminSettings => _adminSettings.value;

  set adminSettings(AdminSettings adminSettings) =>
      this._adminSettings.value = adminSettings;
}
