import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class InitBack4app {
  Future<bool> init() async {
    const keyApplicationId = 'S7QMm0nExKkUFbsIUGLsE5UcHD2O0B7cHssWpeMj';
    const keyClientKey = 'blOxPMjEgsNkfBBvZwufjmizCdcDLkDnMfBD4DIt';
    const keyParseServerUrl = 'https://parseapi.back4app.com';
    await Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      clientKey: keyClientKey,
      autoSendSessionId: true,
      debug: true,
    );
    return (await Parse().healthCheck()).success;
  }
}
