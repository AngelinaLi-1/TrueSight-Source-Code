import 'package:equatable/equatable.dart';

class InstructionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InstructionsStartedState extends InstructionsState {}

class InstructionsLoadedState extends InstructionsState {}

class InstructionsLoadMoreState extends InstructionsState {}

class InstructionsLoadingState extends InstructionsState {}

class InstructionsErrorState extends InstructionsState {
  final String? message;

  InstructionsErrorState(this.message);
}
