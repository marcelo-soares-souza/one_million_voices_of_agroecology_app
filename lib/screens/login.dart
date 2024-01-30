import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:one_million_voices_of_agroecology_app/screens/home.dart';
import 'package:one_million_voices_of_agroecology_app/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  Duration get loginTime => const Duration(milliseconds: 500);

  Future<String?> _authUser(LoginData data) async {
    bool isAuthenticated = await AuthService.login(data.name, data.password);

    return Future.delayed(loginTime).then((_) {
      if (!isAuthenticated) {
        return 'Incorrect e-mail or password.';
      }

      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return 'Password recovery not implemented';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      hideForgotPasswordButton: true,
      hideProvidersTitle: true,
      messages: LoginMessages(signupButton: ''),
      theme: LoginTheme(
        textFieldStyle: const TextStyle(
          color: Colors.white,
        ),
        primaryColor: Theme.of(context).copyWith().shadowColor,
        cardTheme: CardTheme(
            color: Theme.of(context).copyWith().shadowColor,
            surfaceTintColor: Colors.white),
        inputTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Colors.white),
          prefixStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          counterStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.white),
          helperStyle: TextStyle(color: Colors.white),
          suffixStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      logo: const AssetImage('assets/images/logo.png'),
      onLogin: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
