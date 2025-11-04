import 'package:client/features/auth/data/models/session_model.dart';
import 'package:hive/hive.dart';

class HiveSessionStorage {
  static const _boxName = 'sessionBox';

  Future<Box<SessionModel>> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<SessionModel>(_boxName);
    }
    return Hive.box<SessionModel>(_boxName);
  }

  Future<void> saveSession(SessionModel session) async {
    final box = await _openBox();
    await box.put('current_session', session);
  }

  Future<SessionModel?> getSession() async {
    final box = await _openBox();
    return box.get('current_session');
  }

  Future<void> clearSession() async {
    final box = await _openBox();
    await box.delete('current_session');
  }
}
