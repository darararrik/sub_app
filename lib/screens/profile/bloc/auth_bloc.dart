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
      emit(AuthLoading());
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
      emit(AuthSuccess(user!));
    }
  }

  Future<void> _onDeleteAccountRequested(
      DeleteAccountRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.deleteAccount(
        currentPassword: event.currentPassword,
      );
      emit(Unauthenticated());
    } catch (e) {
      emit(const AuthErrorState(error: 'Не удалось удалить аккаунт.'));
    } finally {
      if (state is! AuthErrorState) {
        emit(Unauthenticated()); // Выводим неавторизованный статус
      } else {
        final user = await _authRepository.getCurrentUser();
        emit(AuthSuccess(user!));
      }
    }
  }

  Future<void> _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = await _authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    emit(Unauthenticated());
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading()); // Показываем индикатор загрузки
      final user = await _authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      // Если аутентификация успешна
      if (user == null) {
        emit(const AuthErrorState(error: 'Произошла ошибка.'));
      } else {
        emit(AuthSuccess(user)); // Успех, если пользователь авторизован
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
      if (!(state is AuthSuccess || state is AuthErrorState)) {
        emit(Unauthenticated()); // Выводим неавторизованный статус
      }
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      final user = await _authRepository.createUser(
        email: event.email,
        password: event.password,
      );
      if (user == null) {
        emit(const AuthErrorState(error: 'Произошла ошибка.'));
        emit(Unauthenticated());
      } else {
        await _authRepository.saveUserDataToFirestore(email: event.email);
        emit(AuthSuccess(user));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.message));
    } catch (e) {
      emit(const AuthErrorState(error: 'Произошла ошибка.'));
    } finally {
      // Закрытие состояния загрузки, если оно еще не закрыто
      // Мы гарантируем, что загрузка будет завершена в любом случае.
      // Это гарантирует, что даже если ошибка произошла, состояние загрузки завершится.
      if (!(state is AuthSuccess || state is AuthErrorState)) {
        emit(Unauthenticated()); // Выводим неавторизованный статус
      }
    }
  }
}
