import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sub_app/repositories/auth_repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<UpdatePasswordRequested>(_onUpdatePasswordRequested);
    on<DeleteAccountRequested>(_onDeleteAccountRequested);
    on<SignInRequested>(_onSignInRequested);
  }
  Future<void> _onUpdatePasswordRequested(
      UpdatePasswordRequested event, Emitter<AuthState> emit) async {
    final User? user;
    try {
      emit(AuthLoadingState());
      await _authRepository.updatePassword(
        newPassword: event.newPassword,
        currentPassword: event.currentPassword,
      );
      emit(const AuthSuccessMessage('Пароль успешно обновлен.'));
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.message));
    } catch (e) {
      emit(const AuthErrorState(error: 'Не удалось обновить пароль.'));
    } finally {
      user = await _authRepository.getCurrentUser();
      emit(AuthSuccessState(user!));
    }
  }

  Future<void> _onDeleteAccountRequested(
      DeleteAccountRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await _authRepository.deleteAccount(
        currentPassword: event.currentPassword,
      );
    } catch (e) {
      emit(const AuthErrorState(error: 'Не удалось удалить аккаунт.'));
    } finally {
      if (state is! AuthErrorState) {
        emit(ConfirmState());
      } else {
        final user = await _authRepository.getCurrentUser();
        emit(AuthSuccessState(user!));
      }
    }
  }

  Future<void> _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final user = await _authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthSuccessState(user));
    } else {
      emit(UnauthenticatedState());
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    emit(ConfirmState());
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState()); // Показываем индикатор загрузки
      final user = await _authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      // Если аутентификация успешна
      if (user == null) {
        emit(const AuthErrorState(error: 'Произошла ошибка.'));
      } else {
        emit(AuthSuccessState(user)); // Успех, если пользователь авторизован
      }
    } on FirebaseAuthException catch (e) {
      // Обработка ошибок Firebase
      emit(AuthErrorState(error: e.message));
    } catch (e) {
      // Обработка других ошибок
      emit(const AuthErrorState(error: 'Произошла ошибка'));
    } finally {
      // Закрытие состояния загрузки, если оно еще не закрыто
      // Мы гарантируем, что загрузка будет завершена в любом случае.
      // Это гарантирует, что даже если ошибка произошла, состояние загрузки завершится.
      if (!(state is AuthSuccessState || state is AuthErrorState)) {
        emit(UnauthenticatedState()); // Выводим неавторизованный статус
      }
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());

      final user = await _authRepository.createUser(
        email: event.email,
        password: event.password,
      );
      if (user == null) {
        emit(const AuthErrorState(error: 'Произошла ошибка.'));
        emit(UnauthenticatedState());
      } else {
        await _authRepository.saveUserDataToFirestore(email: event.email);
        emit(AuthSuccessState(user));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.message));
    } catch (e) {
      emit(const AuthErrorState(error: 'Произошла ошибка.'));
    } finally {
      // Закрытие состояния загрузки, если оно еще не закрыто
      // Мы гарантируем, что загрузка будет завершена в любом случае.
      // Это гарантирует, что даже если ошибка произошла, состояние загрузки завершится.
      if (!(state is AuthSuccessState || state is AuthErrorState)) {
        emit(UnauthenticatedState()); // Выводим неавторизованный статус
      }
    }
  }
}
