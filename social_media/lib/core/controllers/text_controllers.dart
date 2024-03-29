import 'package:flutter/material.dart';

class PostTextFieldControllers {
  static final TextEditingController discription = TextEditingController();
  static final TextEditingController tag = TextEditingController();

  static clearControllers() {
    discription.clear();
    tag.clear();
  }
}

class TextFielsPostEditControllers {
  static final TextEditingController postDiscription = TextEditingController();

  static clearControllers() {
    postDiscription.clear();
  }
}

class TextFieldAuthenticationController {
  static final TextEditingController loginPassword = TextEditingController();
  static final TextEditingController loginEmail = TextEditingController();
  static final TextEditingController signupName = TextEditingController();
  static final TextEditingController signupPassword = TextEditingController();
  static final TextEditingController signupEmail = TextEditingController();
  static final TextEditingController signupConformPassword =
      TextEditingController();
}

class EditProfileTextEditingControllers {
  static final TextEditingController name = TextEditingController();
  static final TextEditingController discription = TextEditingController();
}

class NewPostTextEditControllers {
  static final TextEditingController tag = TextEditingController();
  static final TextEditingController discription = TextEditingController();
  static clearControllers() {
    discription.clear();
    tag.clear();
  }
}

class SearchTextControllers {
  static final TextEditingController userSearch = TextEditingController();

  static clearControllers() {
    userSearch.clear();
  }
}

class SearchInMessageTextControllers {
  static final TextEditingController userSearch = TextEditingController();

  static clearControllers() {
    userSearch.clear();
  }
}
