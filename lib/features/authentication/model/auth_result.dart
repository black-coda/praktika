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

enum AuthStatus {
  signedIn('User is signed in'),
  signedOut('User is signed out'),
  error('There was an error');

  final String message;

  const AuthStatus(this.message);
}
