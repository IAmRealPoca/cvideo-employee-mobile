/*
 * File: app_storage.dart
 * Project: CVideo
 * File Created: Tuesday, 16th June 2020 10:27 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Tuesday, 16th June 2020 10:47 am
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './app_components.dart';

class AppStorage {
  /// Create storage
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  AppStorage._privateConstructor();
  static final AppStorage _instance = AppStorage._privateConstructor();

  static AppStorage get instance => _instance;

  /// Store API token to []
  Future<void> writeSecureApiToken(String apiToken) async => await _storage.write(
      key: AppConstants.SECURE_API_TOKEN, value: "$apiToken");

  /// Get API token from [FlutterSecureStorage]
  Future<String> readSecureApiToken() async {
    String secureApiToken =
        await _storage.read(key: AppConstants.SECURE_API_TOKEN);
    return secureApiToken;
  }
}
