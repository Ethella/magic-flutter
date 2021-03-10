import 'dart:async';

import 'package:magic_platform_interface/index.dart';
export 'package:magic_platform_interface/index.dart';

/// The entry point for accessing Magic SDK.
class Magic {
  /// Initializes a new Magic SDK instance using the given [publisherKey],
  /// and returns a [bool].
  ///
  /// On initializing successfully, it will return `true`.
  static Future<bool> initializeMagic({required String publisherKey}) async {
    return await MagicPlatformInterface.instance
        .initializeMagic(publisherKey: publisherKey);
  }

  /// Allows users to login with magic link. Upon successful login, returns
  /// [Future] of [DidToken].
  static Future<DidToken> loginWithMagicLink({required String email}) async {
    return await MagicPlatformInterface.instance
        .loginWithMagicLink(email: email);
  }

  /// Returns [Future] of [bool], which denotes if user has already logged in, or not.
  static Future<bool> isLoggedIn() async {
    return await MagicPlatformInterface.instance.isLoggedIn();
  }

  /// Method to logout, if user is logged in. Returns [Future] of [bool] to denote,
  /// whether user has successfully logged out.
  static Future<bool> logout() async {
    return await MagicPlatformInterface.instance.logout();
  }

  /// Method to update email id of already logged in user. The method should
  /// be used if user is already logged int.
  static Future<bool> updateEmail({required String email}) async {
    return await MagicPlatformInterface.instance.updateEmail(email: email);
  }

  /// Method to get meta data of already logged in user. Returns
  /// [Future] of [GetMetaDataResponse] on success.
  static Future<GetMetaDataResponse> getMetaData() async {
    return await MagicPlatformInterface.instance.getMetaData();
  }
}
