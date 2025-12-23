import 'package:drift/drift.dart';
import '../database/database.dart';
import '../../utils/service_locator.dart';

class UserProfile {
  final int id;
  final String name;
  final String email;
  final String? primaryActivity;
  final String? profilePicture;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.primaryActivity,
    this.profilePicture,
  });

  UserProfile copyWith({
    int? id,
    String? name,
    String? email,
    String? primaryActivity,
    String? profilePicture,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      primaryActivity: primaryActivity ?? this.primaryActivity,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}

class UserRepository {
  final AppDatabase _database = sl<AppDatabase>();

  // Get the default user (ID = 1) or create one if it doesn't exist
  Future<User> getOrCreateDefaultUser() async {
    final user = await (_database.select(
      _database.users,
    )..where((u) => u.id.equals(1))).getSingleOrNull();

    if (user != null) {
      return user;
    }

    // User doesn't exist, create default user
    final int userId = await _database
        .into(_database.users)
        .insert(
          UsersCompanion.insert(
            name: 'Pengguna',
            email: 'pengguna@sleep-tracker.app',
            password: 'default', // In real app, should hash this
            primaryActivity: const Value('Programmer'),
          ),
        );
    return await (_database.select(
      _database.users,
    )..where((u) => u.id.equals(userId))).getSingle();
  }

  // Get user profile
  Future<UserProfile?> getUserProfile(int userId) async {
    final user = await (_database.select(
      _database.users,
    )..where((u) => u.id.equals(userId))).getSingleOrNull();

    if (user == null) return null;
    return UserProfile(
      id: user.id,
      name: user.name,
      email: user.email,
      primaryActivity: user.primaryActivity,
      profilePicture: user.profilePicture,
    );
  }

  // Watch user profile
  Stream<UserProfile?> watchUserProfile(int userId) {
    return (_database.select(
      _database.users,
    )..where((u) => u.id.equals(userId))).watchSingleOrNull().map((user) {
      if (user == null) return null;
      return UserProfile(
        id: user.id,
        name: user.name,
        email: user.email,
        primaryActivity: user.primaryActivity,
        profilePicture: user.profilePicture,
      );
    });
  }

  // Update user profile
  Future<void> updateUserProfile({
    required int userId,
    required String name,
    required String email,
    String? primaryActivity,
    String? profilePicture,
  }) async {
    await (_database.update(
      _database.users,
    )..where((u) => u.id.equals(userId))).write(
      UsersCompanion(
        name: Value(name),
        email: Value(email),
        primaryActivity: primaryActivity != null
            ? Value(primaryActivity)
            : const Value.absent(),
        profilePicture: profilePicture != null
            ? Value(profilePicture)
            : const Value.absent(),
      ),
    );
  }

  // Get default user ID (always use ID 1)
  Future<int> getDefaultUserId() async {
    final user = await getOrCreateDefaultUser();
    return user.id;
  }
}
