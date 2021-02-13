import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:magic_platform_interface/magic_platform_interface.dart';
import 'package:magic_platform_interface/model/did_token_model.dart';
import 'package:magic_platform_interface/model/generate_id_token_model.dart';
import 'package:magic_platform_interface/model/get_id_token_model.dart';
import 'package:magic_platform_interface/model/get_metadata_response_model.dart';

class MagicMethodChannel extends MagicPlatformInterface {
  static const MethodChannel _methodChannel = MethodChannel('magic');

  @override
  Future<GenerateIdTokenResponse> generateIdToken() {
    // TODO: implement generateIdToken
    throw UnimplementedError();
  }

  @override
  Future<GetIdTokenResponse> getIdToken() {
    // TODO: implement getIdToken
    throw UnimplementedError();
  }

  @override
  Future<GetMetaDataResponse> getMetaData() async {
    final result = await _methodChannel.invokeMethod('getMetaData');
    return GetMetaDataResponse.fromJson(Map<String, dynamic>.from(result));
  }

  @override
  Future<bool> isLoggedIn() async {
    final result = await _methodChannel.invokeMethod("isLoggedIn");
    return result;
  }

  @override
  Future<DidToken> loginWithMagicLink({@required String email}) async {
    final result = await _methodChannel.invokeMethod('loginWithMagicLink', email);
    return DidToken.fromJson(Map<String, dynamic>.from(result));
  }

  @override
  Future<bool> logout() async {
    final result = await _methodChannel.invokeMethod('logout');
    return result;
  }

  @override
  Future<bool> updateEmail({@required String email}) async {
    final result = await _methodChannel.invokeMethod('updateEmail', email);
    return result;
  }

  @override
  Future<bool> initializeMagic({String publisherKey}) async {
    return await _methodChannel.invokeMethod('initializeMagic', publisherKey);
  }
}
