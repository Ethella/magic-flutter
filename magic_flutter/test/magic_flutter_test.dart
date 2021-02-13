import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_flutter/magic_flutter.dart';
import 'package:magic_platform_interface/index.dart';

void main() {
  const MethodChannel channel = MethodChannel('magic');
  final publisherKey = "xyz";
  final email = "abc@g.com";
  final didTokenMap = {
    "id": 1,
    "jsonRpc": "jsonRpc",
    "rawResponse": "xyz",
    "result": "result",
  };
  final metaDataMap = {
    "email": email,
    "publicAddress": 'publicAddress',
    "issuer": "issuer",
  };

  TestWidgetsFlutterBinding.ensureInitialized();

  group("Magic Flutter Plugin test", () {
    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == "initializeMagic") {
          if (publisherKey == methodCall.arguments) return true;
          throw PlatformException(code: "FAILED");
        } else if (methodCall.method == "loginWithMagicLink") {
          if (methodCall.arguments == email) return didTokenMap;
          throw PlatformException(code: "Failed");
        } else if (methodCall.method == "isLoggedIn")
          return true;
        else if (methodCall.method == "logout")
          return true;
        else if (methodCall.method == "updateEmail") {
          if (methodCall.arguments == email) return true;
          throw PlatformException(code: "Failed");
        } else if(methodCall.method == "getMetaData")
          return metaDataMap;
      });
    });

    tearDown(() {
      channel.setMockMethodCallHandler(null);
    });

    test('initializeMagic', () async {
      expect(await Magic.initializeMagic(publisherKey: publisherKey), true);
    });

    test('loginWithMagicLink', () async {
      final result = await Magic.loginWithMagicLink(email: email);

      final didToken = DidToken.fromJson(didTokenMap);

      expect(result.id, didToken.id);
      expect(result.result, didToken.result);
      expect(result.rawResponse, didToken.rawResponse);
      expect(result.jsonRpc, didToken.jsonRpc);
    });

    test('isLoggedIn', () async {
      expect(await Magic.isLoggedIn(), true);
    });

    test('logout', () async {
      expect(await Magic.logout(), true);
    });

    test('updateEmail', () async {
      expect(await Magic.updateEmail(email: email), true);
    });

    test('getMetaData', () async {
      final result = await Magic.getMetaData();

      final metaData = GetMetaDataResponse.fromJson(metaDataMap);

      expect(result.email, metaData.email);
      expect(result.issuer, metaData.issuer);
      expect(result.publicAddress, result.publicAddress);
    });
  });
}
