class DidToken {
  final int id;
  final String result;
  final String jsonRpc;
  final String rawResponse;

  DidToken({this.id, this.result, this.jsonRpc, this.rawResponse});

  factory DidToken.fromJson(Map<String, dynamic> response) => DidToken(
        id: response['id'],
        result: response['result'],
        jsonRpc: response['jsonRpc'],
        rawResponse: response['rawResponse'],
      );
}
