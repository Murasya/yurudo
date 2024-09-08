import 'dart:convert';

import 'package:flutter/services.dart';

class GetEnv {
  final Map<String, String> _data = {};

  Future<String> loadJsonAsset(String key) async {
    if (_data[key] != null) return _data[key]!;

    String fileName = const String.fromEnvironment("FLUTTER_APP_FLAVOR") ==
        "dev" ? 'assets/env/dev.json' : 'assets/env/prod.json';
    String jsonString = await rootBundle.loadString(fileName);

    jsonDecode(jsonString).forEach((key, value) => _data[key] = value);
    if (_data[key] == null) throw Exception('Key not found');

    return _data[key]!;
  }

  Future<String> get admobAndroidUnitId async => loadJsonAsset('androidAdUnitId');

  Future<String> get admobIosUnitId async => loadJsonAsset('iosAdUnitId');
}