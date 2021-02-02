import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:magic_platform_interface/index.dart';

class Magic {
  final String publishKey;

  Magic({@required this.publishKey});

  Future<DidToken> loginWithMagicLink({@required String email}) async {
    return await MagicPlatformInterface.instance
        .loginWithMagicLink(email: email);
  }

  Future<IsLoggedInResponse> isLoggedIn() async {
    return await MagicPlatformInterface.instance.isLoggedIn();
  }

  Future<LogoutResponse> logout() async {
    return await MagicPlatformInterface.instance.logout();
  }

  Future<UpdateEmailResponse> updateEmail({@required String email}) async {
    return await MagicPlatformInterface.instance.updateEmail(email: email);
  }

  Future<GetMetaDataResponse> getMetaData() async {
    return await MagicPlatformInterface.instance.getMetaData();
  }
}
