extension StringExtras on String {
  String capitalizeFirst() {
    return "${this.split(" ").map((e) {
      return e[0].toUpperCase() + e.substring(1);
    }).join(" ")}";
  }

  bool isEmailvalid() {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
    if (emailValid) {
      return true;
    } else {
      return false;
    }
  }

  bool isNameValid() {
    final bool nameValid = RegExp("[a-zA-Z]").hasMatch(this);
    if (nameValid) {
      return true;
    } else {
      return false;
    }
  }

  bool isPasswordValid() {
    final bool password =
        this.length >= 4 && !this.contains(" ") ? true : false;
    if (password) {
      return true;
    } else {
      return false;
    }
  }
}
