import 'package:api_review/model/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKey {
  loggedIn,
  id,
  email,
  gender,
  token,
  fullName,
}

class SharedPreferenceController {
  late SharedPreferences _sharedPreferences;
  static final SharedPreferenceController _instance =
      SharedPreferenceController._();

  SharedPreferenceController._();

  factory SharedPreferenceController() {
    return _instance;
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required Student student}) async {
    await _sharedPreferences.setBool(PrefKey.loggedIn.toString(), true);
    await _sharedPreferences.setString(PrefKey.email.toString(), student.email);
    await _sharedPreferences.setString(
        PrefKey.gender.toString(), student.gender);
    await _sharedPreferences.setString(
        PrefKey.fullName.toString(), student.fullName);
    await _sharedPreferences.setString(
        PrefKey.token.toString(), 'Bearer ${student.fullName}');
    await _sharedPreferences.setInt(PrefKey.id.toString(), student.id);
  }

  bool get loggedIn =>
      _sharedPreferences.getBool(PrefKey.loggedIn.toString()) ?? false;

  String get token =>
      _sharedPreferences.getString(PrefKey.token.toString()) ?? '';

  Future<void> clear() async => _sharedPreferences.clear();
}
