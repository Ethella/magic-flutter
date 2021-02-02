class GetMetaDataResponse {
  final String email;
  final String issuer;
  final String publicAddress;

  GetMetaDataResponse({this.email, this.issuer, this.publicAddress});

  factory GetMetaDataResponse.fromJson(Map<String, dynamic> response) =>
      GetMetaDataResponse(
        email: response['email'],
        issuer: response['issuer'],
        publicAddress: response['publicAddress'],
      );
}
