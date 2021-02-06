import 'package:flutter/cupertino.dart';
import 'package:magic_platform_interface/magic_method_channel.dart';
import 'package:magic_platform_interface/model/did_token_model.dart';
import 'package:magic_platform_interface/model/generate_id_token_model.dart';
import 'package:magic_platform_interface/model/get_id_token_model.dart';
import 'package:magic_platform_interface/model/get_metadata_response_model.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class MagicPlatformInterface extends PlatformInterface {
  MagicPlatformInterface() : super(token: _token);

  static MagicPlatformInterface _instance = MagicMethodChannel();

  static final Object _token = Object();

  static MagicPlatformInterface get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [MagicPlatformInterface] when they register themselves.
  static set instance(MagicPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> initializeMagic({@required String publisherKey}) async {
    throw UnimplementedError();
  }

  Future<DidToken> loginWithMagicLink({@required String email}) async {
    throw UnimplementedError();
  }

  Future<bool> updateEmail({@required String email}) async {
    throw UnimplementedError();
  }

  Future<GetIdTokenResponse> getIdToken() async {
    throw UnimplementedError();
  }

  Future<GenerateIdTokenResponse> generateIdToken() async {
    throw UnimplementedError();
  }

  Future<GetMetaDataResponse> getMetaData() async {
    throw UnimplementedError();
  }

  Future<bool> isLoggedIn() async {
    throw UnimplementedError();
  }

  Future<bool> logout() async {
    throw UnimplementedError();
  }
}
