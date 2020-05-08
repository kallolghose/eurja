class APIResponse{
  bool status;
  String message;
  List<String> error;

  APIResponse({this.status, this.message, this.error});
}