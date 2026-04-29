import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'entities/user_profile_cache.dart';

class IsarDatabase {
  IsarDatabase(this.instance);

  final Isar instance;

  static Future<IsarDatabase> open() async {
    if (Isar.instanceNames.contains('core_base')) {
      return IsarDatabase(Isar.getInstance('core_base')!);
    }

    final directory = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [UserProfileCacheSchema],
      name: 'core_base',
      directory: directory.path,
      inspector: false,
    );

    return IsarDatabase(isar);
  }

  Future<void> clear() => instance.writeTxn(() async {
    await instance.clear();
  });
}

final isarDatabaseProvider = Provider<IsarDatabase>((ref) {
  throw UnimplementedError('IsarDatabase is initialized in bootstrap.');
});
