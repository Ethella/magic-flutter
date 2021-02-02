class IsLoggedInResponse {
  final bool result;

  IsLoggedInResponse({this.result});

  factory IsLoggedInResponse.fromJson(Map<String, dynamic> response) =>
      IsLoggedInResponse(result: response['result']);
}
