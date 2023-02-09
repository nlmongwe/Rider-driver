class FireExceptionHelper {
  final createUserWithEmailAndPasswordStatus = {
    'email-already-in-use': 'email already in use try log in',
    'invalid-email': 'email address is not valid',
    'weak-password': 'password is not strong enough',
    'unknown': 'network error please try again'
  };

  final loginWithEmailAndPasswordStatus = {
    'wrong-password': 'password is invalid for the given email',
    'invalid-email': 'the email address is not valid',
    'user-disabled': 'user corresponding to the given email has been disabled',
    'user-not-found': 'user corresponding to the given email',
    'unknown': 'network error please try again',
    'network-request-failed': 'network error try again'
  };

  final resetPasswordStatus = {'user-not-found': 'invalid email'};

  String? createUserWithEmailAndPasswordException(String code) {
    return createUserWithEmailAndPasswordStatus[code];
  }

  String? loginWithEmailAndPasswordException(String code) {
    return loginWithEmailAndPasswordStatus[code];
  }

  String? resetPasswordException(String code) {
    return resetPasswordStatus[code];
  }
}
