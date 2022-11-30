import 'package:bloc/bloc.dart';
import 'package:supe_restaurants/auth/blocs/auth_events.dart';
import 'package:supe_restaurants/auth/blocs/auth_state.dart';
import 'package:supe_restaurants/auth/repository/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthRepository repository;
  AuthBloc(AuthState initialState, this.repository) : super(initialState) {
    on<LoginButtonPressed>(_startEvent);
  }

  _startEvent(LoginButtonPressed event, Emitter<AuthState> emit) async {
    //emit(LoginInitState());
    emit(LoginLoadingState());
    try{
      var data = await repository.login(event.username, event.password);
      if (data['id'] != null) {
        emit(UserLoginSuccessState());
      }
      }catch(e){
        emit(LoginErrorState(message: e.toString()));
    }
  }

}