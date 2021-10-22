
abstract class LoginScreenStates {}

class InitLoginState extends LoginScreenStates {}

class LoginLoadingState extends LoginScreenStates {}

class LoginSuccessState extends LoginScreenStates {
  final String uId;
  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginScreenStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginPasswordIconChange extends LoginScreenStates {}
