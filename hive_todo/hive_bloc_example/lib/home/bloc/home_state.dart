part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  final String? error;
  const HomeInitial({this.error});

  @override
  List<Object> get props => [error.toString()];
}

class SuccessfullLoadedState extends HomeState {
  final String username;
  const SuccessfullLoadedState(this.username);
  @override
  List<Object> get props => [username];
}

class RegisteringServiceState extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
