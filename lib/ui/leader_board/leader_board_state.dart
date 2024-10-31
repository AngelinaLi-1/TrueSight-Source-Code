import 'package:equatable/equatable.dart';
import 'package:realorfake/data/responses/leader_board_model.dart';

class LeaderBoardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LeaderBoardStartedState extends LeaderBoardState {}

class LeaderBoardLoadedState extends LeaderBoardState {
  final List<LeaderBoardModel> mList;

  LeaderBoardLoadedState({required this.mList});
}

class LeaderBoardLoadingState extends LeaderBoardState {}

class LeaderBoardLoadMoreState extends LeaderBoardState {}

class LeaderBoardEmptyState extends LeaderBoardState {}

class LeaderBoardErrorState extends LeaderBoardState {
  final String? message;

  LeaderBoardErrorState(this.message);
}
