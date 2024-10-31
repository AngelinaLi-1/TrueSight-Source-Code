import 'package:equatable/equatable.dart';
import 'package:realorfake/data/responses/quiz_model.dart';

class ResultSummaryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResultSummaryStartedState extends ResultSummaryState {}

class ResultSummaryLoadedState extends ResultSummaryState {
  final QuizModel obj;
  ResultSummaryLoadedState(this.obj);
}

class ResultSummaryLoadingState extends ResultSummaryState {}

class ResultSummaryErrorState extends ResultSummaryState {
  final String? message;

  ResultSummaryErrorState(this.message);
}
