import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/repositories/user_repository.dart';

// States
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileUpdating extends ProfileState {
  final UserProfile profile;

  const ProfileUpdating(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileUpdated extends ProfileState {
  final UserProfile profile;

  const ProfileUpdated(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

// Cubit
class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;
  int _userId = 1; // Default user ID

  ProfileCubit(this._userRepository) : super(ProfileInitial()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await _userRepository.getUserProfile(_userId);
      if (profile != null) {
        emit(ProfileLoaded(profile));
      } else {
        // Create default profile
        final user = await _userRepository.getOrCreateDefaultUser();
        _userId = user.id;
        final newProfile = await _userRepository.getUserProfile(_userId);
        if (newProfile != null) {
          emit(ProfileLoaded(newProfile));
        } else {
          emit(const ProfileError('Gagal memuat profil'));
        }
      }
    } catch (e) {
      emit(ProfileError('Gagal memuat profil: ${e.toString()}'));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    String? primaryActivity,
    String? profilePicture,
  }) async {
    if (state is ProfileLoaded) {
      final currentProfile = (state as ProfileLoaded).profile;
      emit(ProfileUpdating(currentProfile));

      try {
        await _userRepository.updateUserProfile(
          userId: _userId,
          name: name,
          email: email,
          primaryActivity: primaryActivity,
          profilePicture: profilePicture,
        );

        final updatedProfile = currentProfile.copyWith(
          name: name,
          email: email,
          primaryActivity: primaryActivity,
          profilePicture: profilePicture,
        );

        emit(ProfileUpdated(updatedProfile));
        emit(ProfileLoaded(updatedProfile));
      } catch (e) {
        emit(ProfileError('Gagal memperbarui profil: ${e.toString()}'));
        if (state is! ProfileError) {
          emit(ProfileLoaded(currentProfile));
        }
      }
    }
  }

  void resetError() {
    if (state is ProfileError) {
      _loadProfile();
    }
  }
}
