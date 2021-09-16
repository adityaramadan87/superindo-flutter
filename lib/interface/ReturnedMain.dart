class ReturnedMain {
  void onSuccess(Object data, {dynamic flag}){}

  void onError(String message){}

  bool onProgress(bool isLoading){
    return isLoading;
  }
}