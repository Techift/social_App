class Validators {
  static String? validateEmail(String? value) {
    return switch (value) { 
      null || '' => 'Email is required',
      String e
          when !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(e) =>
        'Please enter a valid email',
      _ => null,
    };
  }

  static String? validatePassword(String? value) {
    return switch (value) {
      null || '' => 'Password is required',
      String p when p.length < 6 =>
        'Password must be at least 6 characters',
      _ => null,
    };
  }

  static String? validateUsername(String? value) {
    return switch (value) {
      null || '' => 'Username is required',
      String u when u.length < 3 =>
        'Username must be at least 3 characters',
      _ => null,
    };
  }
}