import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/repositories/sleep_repository.dart';

// Events
abstract class AnalysisEvent extends Equatable {
  const AnalysisEvent();
  @override
  List<Object> get props => [];
}

class FetchAnalysisData extends AnalysisEvent {}

// States
abstract class AnalysisState extends Equatable {
  const AnalysisState();
  @override
  List<Object> get props => [];
}

class AnalysisInitial extends AnalysisState {}

class AnalysisLoading extends AnalysisState {}

class AnalysisLoaded extends AnalysisState {
  final List<FactorAnalysisResult> analysisResults;
  const AnalysisLoaded(this.analysisResults);
  @override
  List<Object> get props => [analysisResults];
}

class AnalysisError extends AnalysisState {}

// BLoC
class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  final SleepRepository _sleepRepository;

  AnalysisBloc(this._sleepRepository) : super(AnalysisInitial()) {
    on<FetchAnalysisData>(_onFetchAnalysisData);
  }

  Future<void> _onFetchAnalysisData(
    FetchAnalysisData event,
    Emitter<AnalysisState> emit,
  ) async {
    emit(AnalysisLoading());
    try {
      final results = await _sleepRepository.analyzeFactors();
      emit(AnalysisLoaded(results));
    } catch (_) {
      emit(AnalysisError());
    }
  }
}
