import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:magic_platform_interface/index.dart';

class Magic {

  static Future<bool> initializeMagic({@required String publisherKey}) async {
    return await MagicPlatformInterface.instance
        .initializeMagic(publisherKey: publisherKey);
  }

  static Future<DidToken> loginWithMagicLink({@required String email}) async {
    return await MagicPlatformInterface.instance
        .loginWithMagicLink(email: email);
  }

  static Future<IsLoggedInResponse> isLoggedIn() async {
    return await MagicPlatformInterface.instance.isLoggedIn();
  }

  static Future<LogoutResponse> logout() async {
    return await MagicPlatformInterface.instance.logout();
  }

  static Future<UpdateEmailResponse> updateEmail({
    @required String email,
  }) async {
    return await MagicPlatformInterface.instance.updateEmail(email: email);
  }

  static Future<GetMetaDataResponse> getMetaData() async {
    return await MagicPlatformInterface.instance.getMetaData();
  }
}
