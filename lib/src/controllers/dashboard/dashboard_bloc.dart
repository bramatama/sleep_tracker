import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/repositories/sleep_repository.dart';

// State
class DashboardState extends Equatable {
  final SleepSessionWithFactors? lastSession;
  final List<double> weeklyData;

  const DashboardState({this.lastSession, this.weeklyData = const []});

  @override
  List<Object?> get props => [lastSession, weeklyData];
}

// Cubit
class DashboardCubit extends Cubit<DashboardState> {
  final SleepRepository _sleepRepository;

  DashboardCubit(this._sleepRepository) : super(const DashboardState()) {
    _sleepRepository.watchLastSleepSession().listen((session) {
      emit(DashboardState(lastSession: session, weeklyData: state.weeklyData));
    });

    _sleepRepository.watchWeeklySleepDurations().listen((data) {
      emit(DashboardState(lastSession: state.lastSession, weeklyData: data));
    });
  }
}
