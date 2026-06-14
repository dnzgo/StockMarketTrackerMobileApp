class InputValidation {
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return "Email is required";
    }

    if (!email.contains("@")) {
      return "Invalid email";
    }

    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return "Password is required";
    }

    if (password.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  static String? validateName(String name) {
    if (name.isEmpty) {
      return "Name is required";
    }

    if (name.length < 2) {
      return "Name is too short";
    }

    return null;
  }
}