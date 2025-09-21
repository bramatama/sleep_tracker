import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep_tracker/src/services/storage_service.dart';

// State untuk cubit
enum OnboardingStatus { initial, loading, success }

class OnboardingCubit extends Cubit<OnboardingStatus> {
  final StorageService _storageService;

  OnboardingCubit(this._storageService) : super(OnboardingStatus.initial);

  Future<void> saveUserNameAndContinue(String name) async {
    if (name.isEmpty) return; // Jangan lakukan apa-apa jika nama kosong

    emit(OnboardingStatus.loading);
    await _storageService.saveUserName(name);
    emit(OnboardingStatus.success);
  }
}
