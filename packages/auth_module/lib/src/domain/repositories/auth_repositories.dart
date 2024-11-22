
import 'package:core_module/core_module.dart';

abstract class IOnlineAuthRepository implements ISignInEmail, ISignInGoogle, IGetCurrentUser{}
abstract class IOfflineAuthRepository implements IGetLocalUser, ISaveLocalUser, IGetAccessToken, ISaveAccessToken{}

abstract class ISignInEmail {
  Future<String?> signInWithEmail(String email, String password);
}

abstract class ISignInGoogle {
  Future<String?> signInWithGoogle();
}

abstract class IGetCurrentUser {
  UserEntity? getCurrentUser();
}

abstract class IGetLocalUser{
  Future<UserEntity?> getLocalUser();
}

abstract class IGetAccessToken{
  Future<String?> getAccessToken();
}

abstract class ISaveLocalUser{
  void saveLocalUser(UserEntity user);
}

abstract class ISaveAccessToken{
  void saveAccessToken(String token);
}