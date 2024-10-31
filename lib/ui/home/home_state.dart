import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeStartedState extends HomeState {}

class HomeRefreshState extends HomeState {}

class HomeLoadedState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadingFinishState extends HomeState {}

class HomeCustomLoadingState extends HomeState {}

class HomeTokenMissingState extends HomeState {}

class HomeErrorState extends HomeState {
  final String? message;

  HomeErrorState(this.message);
}
