import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_traker_flutter_course/app/sign_in/validators.dart';
import 'package:time_traker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_traker_flutter_course/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_traker_flutter_course/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'email_sign_in_model.dart';
import 'package:time_traker_flutter_course/app/sign_in/email_sign_in_bloc.dart';
class EmailSignInFormBlocBased extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignInFormBlocBased({@required this.bloc});
  final EmailSignInBloc bloc;
  static Widget create(BuildContext context){
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, _) => EmailSignInFormBlocBased(bloc: bloc),

    ),
    dispose: (_, bloc)=> bloc.dispose(),
    );
  }


  @override
  _EmailSignInFormBlocBasedState createState() => _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose(){
    //print('dispose called');
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  void _submit() async{
    try{
      await widget.bloc.submit();
      Navigator.of(context).pop();//성공시 pop해서 제거
    }
    on FirebaseAuthException catch(e){
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    }
  }

  void  _emailEditingComplete(EmailSignInModel model){
    final newFocus = widget.emailValidator.isValid(model.email)
        ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }
  void _toggleFormType(EmailSignInModel model) {
    widget.bloc.updateWith(
      email: '',
      password: '',
      formType: model.formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,
        isLoading: false,
        submitted: false,
    );
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    final primaryText = model.formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText = model.formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    bool submitEnabled = widget.emailValidator.isValid(model.email)
        && widget.passwordValidator.isValid(model.password) && !model.isLoading; //비어있는지 확인

    return [
      _buildEmailTextField(model),
      SizedBox(height: 8.0),
      _buildPasswordTextField(model),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null ,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(secondaryText),
        onPressed: !model.isLoading ? ()=> _toggleFormType(model) : null,
      ),
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    bool showErrorText = model.submitted && !widget.passwordValidator.isValid(model.password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode, //패스워드 포커스노드드
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: model.isLoading == false,
      ),
      obscureText: true, //암호화
      textInputAction: TextInputAction.done,
      onChanged: (password) => widget.bloc.updateWith(password: password ),
      onEditingComplete: _submit,//다입력시 _submit호출
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    bool showErrorText = model.submitted && !widget.emailValidator.isValid(model.email) ;
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode, //이메일 포커스노드
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com', //선택시
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: model.isLoading == false,
      ),
      keyboardType: TextInputType.emailAddress, //@
      autocorrect: false,//단어 추천 X
      textInputAction: TextInputAction.next,
      onChanged: (email) => widget.bloc.updateWith(email: email),
      onEditingComplete: () => _emailEditingComplete(model),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(

      stream: widget.bloc.modelStream,
      initialData: EmailSignInModel(),
      builder: (context, snapshot) {
        final EmailSignInModel model = snapshot.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, //패딩 안 차일드 길이 조절 (가로)
            mainAxisSize: MainAxisSize.min, //Column 사이즈 조절
            children: _buildChildren(model),
          ),
        );
      }
    );
  }
}
