class GetMetaDataResponse {
  final String email;
  final String issuer;
  final String publicAddress;

  GetMetaDataResponse({
    required this.email,
    required this.issuer,
    required this.publicAddress,
  });

  factory GetMetaDataResponse.fromJson(Map<String, dynamic> response) =>
      GetMetaDataResponse(
        email: response['email'] ?? '',
        issuer: response['issuer'] ?? '',
        publicAddress: response['publicAddress'] ?? '',
      );
}
