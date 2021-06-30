//email_sign_in_change_model.dart
import 'package:flutter/cupertino.dart';
import 'package:time_traker_flutter_course/app/sign_in/validators.dart';
import 'email_sign_in_model.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel({
    this.email='',
    this.password='',
    this.formType=EmailSignInFormType.signIn,
    this.isLoading=false,
    this.submitted =false,
  });
   String email;
   String password;
   EmailSignInFormType formType;
   bool isLoading;
   bool submitted;

  String get primaryButtonText{
    return formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryButtonText{
    return formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get canSubmit{
    return emailValidator.isValid(email)
        && passwordValidator.isValid(password)
        && !isLoading;
  }

  String get passwordErrorText{
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText{
    bool showErrorText = submitted && !emailValidator.isValid(email) ;
    return showErrorText ? invalidEmailErrorText : null;
  }

  void toggleFormType(){
    final formType = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }
  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);
  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }){
    this.email= email ?? this.email;
    this.password= password ?? this.password;
    this.formType= formType ?? this.formType;
    this.isLoading= isLoading ?? this.isLoading;
    this.submitted= submitted ?? this.submitted;
    notifyListeners();
  }
}
