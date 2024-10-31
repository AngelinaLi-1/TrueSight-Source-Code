import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileStartedState extends ProfileState {}

class ProfileLoadedState extends ProfileState {}

class ProfileLoadMoreState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String? message;

  ProfileErrorState(this.message);
}
