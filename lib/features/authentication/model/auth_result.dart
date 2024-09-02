sealed class AuthResult {

}

class Success implements AuthResult {
  final String ? msg;

  Success({ this.msg});
}

class Error implements AuthResult {
  final String ? msg;

  Error({this.msg});
}


