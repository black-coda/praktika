sealed class AuthResults {

}

class Success implements AuthResults {
  final String ? msg;

  Success({ this.msg});
}

class Error implements AuthResults {
  final String ? msg;

  Error({this.msg});
}

enum AuthResult {
  signedIn('User is signed in'),
  signedOut('User is signed out'),
  error('There was an error');

  final String message;

  const AuthResult(this.message);
}
