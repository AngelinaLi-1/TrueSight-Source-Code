import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SplashStartedState extends SplashState {}

class SplashLoadingState extends SplashState {}

class SplashErrorState extends SplashState {
  final String? message;
  SplashErrorState({this.message = ""});
  @override
  List<Object?> get props => [message];
}
