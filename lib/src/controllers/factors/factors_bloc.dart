import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/database/database.dart'; // <-- FIX: Import ini yang dibutuhkan
import '../../models/repositories/factor_repository.dart';
import '../../utils/service_locator.dart';

// Events
abstract class FactorsEvent extends Equatable {
  const FactorsEvent();
  @override
  List<Object> get props => [];
}

class LoadFactors extends FactorsEvent {}

class AddFactor extends FactorsEvent {
  final String name;
  final String icon;
  const AddFactor(this.name, this.icon);
  @override
  List<Object> get props => [name, icon];
}

class EditFactor extends FactorsEvent {
  final FactorsCompanion factor;
  const EditFactor(this.factor);
  @override
  List<Object> get props => [factor];
}

class DeleteFactor extends FactorsEvent {
  final int id;
  const DeleteFactor(this.id);
  @override
  List<Object> get props => [id];
}

// States
abstract class FactorsState extends Equatable {
  const FactorsState();
  @override
  List<Object> get props => [];
}

class FactorsInitial extends FactorsState {}

class FactorsLoading extends FactorsState {}

class FactorsLoaded extends FactorsState {
  final List<Factor> factors;
  const FactorsLoaded(this.factors);
  @override
  List<Object> get props => [factors];
}

class FactorsError extends FactorsState {
  final String message;
  const FactorsError(this.message);
  @override
  List<Object> get props => [message];
}

// BLoC
class FactorsBloc extends Bloc<FactorsEvent, FactorsState> {
  final FactorRepository _factorRepository = sl<FactorRepository>();
  Stream<List<Factor>>? _factorsStream;

  FactorsBloc() : super(FactorsInitial()) {
    on<LoadFactors>(_onLoadFactors);
    on<AddFactor>(_onAddFactor);
    on<EditFactor>(_onEditFactor);
    on<DeleteFactor>(_onDeleteFactor);
    on<UpdateFactorsList>(_onUpdateFactorsList);
    
    // Automatically load factors on initialization
    add(LoadFactors());
  }

  void _onLoadFactors(LoadFactors event, Emitter<FactorsState> emit) {
    emit(FactorsLoading());
    _factorsStream ??= _factorRepository.watchAllFactors();
    _factorsStream!.listen((factors) {
      add(UpdateFactorsList(factors));
    });
  }

  void _onUpdateFactorsList(
    UpdateFactorsList event,
    Emitter<FactorsState> emit,
  ) {
    emit(FactorsLoaded(event.factors));
  }

  Future<void> _onAddFactor(AddFactor event, Emitter<FactorsState> emit) async {
    await _factorRepository.addFactor(event.name, event.icon);
  }

  Future<void> _onEditFactor(
    EditFactor event,
    Emitter<FactorsState> emit,
  ) async {
    await _factorRepository.updateFactor(event.factor);
  }

  Future<void> _onDeleteFactor(
    DeleteFactor event,
    Emitter<FactorsState> emit,
  ) async {
    await _factorRepository.deleteFactor(event.id);
  }
}

class UpdateFactorsList extends FactorsEvent {
  final List<Factor> factors;
  const UpdateFactorsList(this.factors);
  @override
  List<Object> get props => [factors];
}
