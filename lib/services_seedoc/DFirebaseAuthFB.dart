import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import '../services/LoggerService.dart';

final FacebookLogin facebookSignIn = new FacebookLogin();



Future<Null> signInWithFacebook() async {
  final FacebookLoginResult result =
        await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        logger.i('''
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        logger.i('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        logger.i('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }



void signOutFacebook() async{
  await facebookSignIn.logOut();

  logger.i("User Sign Out");
}