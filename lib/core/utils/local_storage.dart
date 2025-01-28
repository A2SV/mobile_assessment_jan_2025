import 'dart:developer';

import 'package:mobile_assessment_jan_2025/core/utils/local_storage_key.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalStorage {
  static SharedPreferences? _preferences;
  LocalStorage._();
  static LocalStorage? _localStorage;
  static LocalStorage instance = LocalStorage._();
  static Future<LocalStorage> getInstance() async {
    if (_localStorage == null){
      _localStorage = LocalStorage._();
      await _localStorage!._init();
    }
    return _localStorage!;
  }
  /// init shared preferences
  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }
 
 
  /// set refresh token
  Future<void> setRefreshToken(String token) async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.setString(LocalStorageKey.refreshToken, token);
  }
  /// get refresh token
  String? getRefreshToken() {
    if (_preferences == null) {
      return null;
    }
    return _preferences!.getString(LocalStorageKey.refreshToken);
  }
  /// delete refresh token
  Future<void> deleteRefreshToken() async {
    if (_preferences == null) {
      return;
    }
    await _preferences!.remove(LocalStorageKey.refreshToken);
  }
  /// set token
  Future<void> setAccessToken(String token) async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.setString(LocalStorageKey.accessToken, token);
  }
  /// get token
  String? getAccessToken() {
    if (_preferences == null) {
      return null;
    }
    return _preferences?.getString(LocalStorageKey.accessToken);
  }
  /// delete token
  Future<void> deleteAccessToken() async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.remove(LocalStorageKey.accessToken);
  }
 



}
