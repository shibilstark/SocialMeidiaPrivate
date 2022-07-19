import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/accounts/account_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AccountRepo _accountServices;
  AuthBloc(this._accountServices) : super(AuthStateInitial()) {
    on<CreateAccount>((event, emit) async {
      emit(AuthStateLoading());

      final response = await _accountServices.createAccount(
          model: event.model, password: event.password);

      response.fold(
        (success) {
          emit(AuthStateAccountCreateSuccess(success));
        },
        (failure) {
          emit(AuthStateAccountCreateError(failure));
        },
      );
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthStateLoading());

      final response = await _accountServices.login(
          email: event.email, password: event.password);

      response.fold(
        (success) {
          emit(AuthStateLogginSuccess(success));
        },
        (failure) {
          emit(AuthStateLogginError(failure));
        },
      );
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthStateLoading());

      final response = await _accountServices.logOut();

      response.fold(
        (success) {
          emit(AuthStateLogginSuccess(success));
        },
        (failure) {
          emit(AuthStateLogginError(failure));
        },
      );
    });
  }
}
