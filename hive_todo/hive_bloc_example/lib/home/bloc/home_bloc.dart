import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_bloc_example/service/authentication_service.dart';
import 'package:hive_bloc_example/service/todo_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoServices _todo;
  HomeBloc(this._auth, this._todo) : super(RegisteringServiceState()) {
    on<LoginEvent>(
      (event, emit) async {
        print(event);
        final user = _auth.authenticateUser(event.username, event.password);
        emit(SuccessfullLoadedState(user.toString()));
        print("ini data ${user.toString()}");
        emit(const HomeInitial());
      },
    );

    on<RegisterAccountEvent>((event, emit) async {
      final result = await _auth.createUser(event.username, event.password);
      switch (result) {
        case UserCreationResult.success:
          emit(SuccessfullLoadedState(event.username));
          break;
        case UserCreationResult.failure:
          emit(const HomeInitial(error: "There's been an error"));
          break;
        case UserCreationResult.already_exist:
          emit(const HomeInitial(error: "Use Already Exist"));
          break;
      }
    });

    on<RegisteringServiceEvent>(
      (event, emit) async {
        await _auth.init();
        await _todo.init();
        emit(const HomeInitial());
      },
    );
  }
}
