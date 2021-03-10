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
    return GetMetaDataResponse.fromJson(
        await _methodChannel.invokeMapMethod<String, dynamic>('getMetaData') ??
            <String, dynamic>{});
  }

  @override
  Future<bool> isLoggedIn() async {
    final result = await _methodChannel.invokeMethod("isLoggedIn") as bool;
    return result;
  }

  @override
  Future<DidToken> loginWithMagicLink({required String email}) async {
    final result = await _methodChannel.invokeMapMethod<String, dynamic>(
            'loginWithMagicLink', email) ??
        <String, dynamic>{};
    return DidToken.fromJson(result);
  }

  @override
  Future<bool> logout() async {
    final result = await _methodChannel.invokeMethod('logout') as bool;
    return result;
  }

  @override
  Future<bool> updateEmail({required String email}) async {
    final result =
        await _methodChannel.invokeMethod('updateEmail', email) as bool;
    return result;
  }

  @override
  Future<bool> initializeMagic({required String publisherKey}) async {
    return await _methodChannel.invokeMethod('initializeMagic', publisherKey)
        as bool;
  }
}
