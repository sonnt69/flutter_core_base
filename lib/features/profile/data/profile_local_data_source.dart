import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/entities/user_profile_cache.dart';
import '../../../core/database/isar_database.dart';
import '../domain/user_profile.dart';

class ProfileLocalDataSource {
  ProfileLocalDataSource(this._database);

  static const _currentUserCacheId = 1;

  final IsarDatabase _database;

  Future<UserProfile?> readCurrentUser() async {
    final cached = await _database.instance.userProfileCaches.get(
      _currentUserCacheId,
    );
    if (cached == null) return null;

    return UserProfile(
      id: cached.userId,
      name: cached.name,
      email: cached.email,
      phone: cached.phone,
      avatarUrl: cached.avatarUrl,
    );
  }

  Future<void> saveCurrentUser(UserProfile profile) async {
    final entity = UserProfileCache()
      ..id = _currentUserCacheId
      ..userId = profile.id
      ..name = profile.name
      ..email = profile.email
      ..phone = profile.phone
      ..avatarUrl = profile.avatarUrl
      ..updatedAt = DateTime.now();

    await _database.instance.writeTxn(() async {
      await _database.instance.userProfileCaches.put(entity);
    });
  }

  Future<void> clear() async {
    await _database.instance.writeTxn(() async {
      await _database.instance.userProfileCaches.clear();
    });
  }
}

final profileLocalDataSourceProvider = Provider<ProfileLocalDataSource>((ref) {
  return ProfileLocalDataSource(ref.watch(isarDatabaseProvider));
});
