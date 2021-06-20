
import 'dart:async';
class SignInBloc{
  //loading state
  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream; //input Stream

  void dispose(){
    _isLoadingController.close();
  }
  void setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

}