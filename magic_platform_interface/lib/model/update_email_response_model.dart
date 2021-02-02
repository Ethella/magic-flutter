class UpdateEmailResponse {
  final bool result;

  UpdateEmailResponse({this.result});

  factory UpdateEmailResponse.fromJson(Map<String, dynamic> response) =>
      UpdateEmailResponse(result: response['result']);
}
