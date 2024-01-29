import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pkce_auth_with_flutter/app.dart';
import 'package:pkce_auth_with_flutter/utils/config_reader.dart';
import 'package:pkce_auth_with_flutter/utils/strings.dart';

String? devClientId;
String? devClientSecret;
String? prodClientId;
String? prodClientSecret;

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();
  switch (env) {
    case stagingENV:
      devClientId = ConfigReader.getStagingClientId();
      devClientSecret = ConfigReader.getStagingClientSecret();
      break;
    case prodENV:
      prodClientId = ConfigReader.getProdClientId();
      prodClientSecret = ConfigReader.getProdClientSecret();
      break;
  }

  log(devClientId.toString(), name: "Dev Client Id");
  log(devClientSecret.toString(), name: "Dev Client Secret");
  log(prodClientId.toString(), name: "Prod Client Id");
  log(prodClientSecret.toString(), name: "Prod Client Secret");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}
