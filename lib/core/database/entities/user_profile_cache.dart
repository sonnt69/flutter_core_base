import 'package:isar/isar.dart';

part 'user_profile_cache.g.dart';

@collection
class UserProfileCache {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String userId;

  late String name;
  late String email;
  String? phone;
  String? avatarUrl;
  late DateTime updatedAt;
}
