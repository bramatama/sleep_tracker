import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/repositories/sleep_repository.dart';

// State
class DashboardState extends Equatable {
  final SleepSessionWithFactors? lastSession;
  final List<double> weeklyData;
  final bool isLoading;

  const DashboardState({
    this.lastSession,
    this.weeklyData = const [],
    this.isLoading = true,
  });

  @override
  List<Object?> get props => [lastSession, weeklyData, isLoading];
}

// Cubit
class DashboardCubit extends Cubit<DashboardState> {
  final SleepRepository _sleepRepository;

  DashboardCubit(this._sleepRepository) : super(const DashboardState()) {
    _initializeListeners();
  }

  void _initializeListeners() {
    // Listen to last sleep session
    _sleepRepository.watchLastSleepSession().listen((session) {
      emit(DashboardState(
        lastSession: session,
        weeklyData: state.weeklyData,
        isLoading: false,
      ));
    });

    // Listen to weekly sleep durations
    _sleepRepository.watchWeeklySleepDurations().listen((data) {
      emit(DashboardState(
        lastSession: state.lastSession,
        weeklyData: data,
        isLoading: false,
      ));
    });
  }
}
