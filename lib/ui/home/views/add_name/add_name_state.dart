import 'package:equatable/equatable.dart';

class AddNameState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddNameStartedState extends AddNameState {}

class AddNameRefreshState extends AddNameState {}

class AddNameLoadedState extends AddNameState {}

class AddNameLoadingState extends AddNameState {}

class AddNameErrorState extends AddNameState {
  final String? message;

  AddNameErrorState(this.message);
}
