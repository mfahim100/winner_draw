class AuthExceptionsService {
  static generateExceptionMessage(e) {
    print(e.code);
    String errorMessage;
    switch (e.code) {
      case "email-already-in-use":
        errorMessage =
        "Email is already registered";
        break;
      case "invalid-email":
        errorMessage = "Your email address appears to be malformed.";
        break;
      case "weak-password":
        errorMessage =
        "The password provided is too weak.";
        break;
      case "wrong-password":
        errorMessage = "Wrong password entered";
        break;
      case "user-not-found":
        errorMessage = "User not found for this email";
        break;
      case "user-disabled":
        errorMessage = "User with this email has been disabled.";
        break;
      case "operation-not-allowed":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;

    //Todo: Handle no internet exception as well.

      default:
        errorMessage = "An undefined Error happened.";
    }
    return errorMessage;
  }
}
