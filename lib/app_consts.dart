import 'package:flutter/services.dart';

class AppConsts {
  static const flashChannelName = "com.aplimelta.flashlight/main";
  static const nativeEventIsTorchAvailable = 'torch_available';

  static const nativeEventEnableTorch = 'enable_torch';
  static const errorEnableTorchExistentUser =
      'enable_torch_error_existent_user';
  static const errorEnableTorchNotAvailable = 'enable_torch_not_available';

  static const nativeEventDisableTorch = 'disable_torch';
  static const errorDisableTorchExistentUser =
      'disable_torch_error_existent_user';
  static const errorDIsableTorchNotAvailable = 'disable_torch_not_available';
}