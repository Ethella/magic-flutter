class LogoutResponse {
  final bool result;

  LogoutResponse({this.result});

  factory LogoutResponse.fromJson(Map<String, dynamic> response) =>
      LogoutResponse(result: response['result']);
}
