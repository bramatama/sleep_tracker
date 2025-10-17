import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/database/database.dart';
import '../../models/repositories/factor_repository.dart';
import '../../models/repositories/sleep_repository.dart';

// State
enum SleepStatus { setup, active, finished }

class SleepSessionState extends Equatable {
  final SleepStatus status;
  final List<Factor> allFactors;
  final Set<Factor> selectedFactors;
  final int? activeSessionId;

  const SleepSessionState({
    this.status = SleepStatus.setup,
    this.allFactors = const [],
    this.selectedFactors = const {},
    this.activeSessionId,
  });

  SleepSessionState copyWith({
    SleepStatus? status,
    List<Factor>? allFactors,
    Set<Factor>? selectedFactors,
    int? activeSessionId,
  }) {
    return SleepSessionState(
      status: status ?? this.status,
      allFactors: allFactors ?? this.allFactors,
      selectedFactors: selectedFactors ?? this.selectedFactors,
      activeSessionId: activeSessionId ?? this.activeSessionId,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allFactors,
    selectedFactors,
    activeSessionId,
  ];
}

// Cubit
class SleepSessionCubit extends Cubit<SleepSessionState> {
  final SleepRepository _sleepRepo;
  final FactorRepository _factorRepo;

  SleepSessionCubit(this._sleepRepo, this._factorRepo)
    : super(const SleepSessionState());

  Future<void> loadFactors() async {
    _factorRepo.watchAllFactors().listen((factors) {
      emit(state.copyWith(allFactors: factors));
    });
  }

  void toggleFactor(Factor factor) {
    final newSelection = Set<Factor>.from(state.selectedFactors);
    if (newSelection.contains(factor)) {
      newSelection.remove(factor);
    } else {
      newSelection.add(factor);
    }
    emit(state.copyWith(selectedFactors: newSelection));
  }

  Future<void> startSession() async {
    final sessionId = await _sleepRepo.startNewSession();
    emit(
      state.copyWith(status: SleepStatus.active, activeSessionId: sessionId),
    );
  }

  Future<void> endSession(int quality) async {
    if (state.activeSessionId != null) {
      await _sleepRepo.endSession(
        sessionId: state.activeSessionId!,
        quality: quality,
        selectedFactors: state.selectedFactors.toList(),
      );
      emit(state.copyWith(status: SleepStatus.finished));
    }
  }
}
