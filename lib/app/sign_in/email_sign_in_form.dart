import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_traker_flutter_course/app/sign_in/validators.dart';
import 'package:time_traker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_traker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_traker_flutter_course/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_traker_flutter_course/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
enum EmailSignInFormType { signIn, register }
class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode(); //포커스 노드생성
  final FocusNode _passwordFocusNode = FocusNode();
  //getter setter
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submitted = false;
  bool _isLoading = false;

  @override
  void dispose(){
    //print('dispose called');
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose()''
    super.dispose();
  }


  void _submit() async{
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try{
      final auth = Provider.of<AuthBase>(context, listen: false);
      if(_formType == EmailSignInFormType.signIn){//signIn상태라면
        await auth.signInWithEmailAndPassword(_email, _password);//로그인
      }else{
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();//성공시 pop해서 제거
    }
    on FirebaseAuthException catch(e){
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );

    } finally{
      setState(() { //무조건 실행
        _isLoading = false;
      });
    }
  }
  void  _emailEditingComplete(){
    final newFocus = widget.emailValidator.isValid(_email)
    ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }
  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    bool submitEnabled = widget.emailValidator.isValid(_email)
        && widget.passwordValidator.isValid(_password) && !_isLoading; //비어있는지 확인

    return [
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null ,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(secondaryText),
        onPressed: !_isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText = _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode, //패스워드 포커스노드드
     decoration: InputDecoration(
       labelText: 'Password',
       errorText: showErrorText ? widget.invalidPasswordErrorText : null,
       enabled: _isLoading == false,
      ),
      obscureText: true, //암호화
      textInputAction: TextInputAction.done,
      onChanged: (password) => _updateState(),
      onEditingComplete: _submit,//다입력시 _submit호출
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email) ;
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode, //이메일 포커스노드
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com', //선택시
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      keyboardType: TextInputType.emailAddress, //@
      autocorrect: false,//단어 추천 X
      textInputAction: TextInputAction.next,
      onChanged: (email) => _updateState(),
      onEditingComplete: _emailEditingComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, //패딩 안 차일드 길이 조절 (가로)
        mainAxisSize: MainAxisSize.min, //Column 사이즈 조절
        children: _buildChildren(),
      ),
    );
  }
  void _updateState(){
    print('email: $_email, password: $_password');
    setState((){
    });
  }
}
