import 'package:medico_app/providers/global_provider.dart';
import 'package:medico_app/services/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider =
    StateNotifierProvider<AuthProvider, Map<String, dynamic>>((ref) {
  final as = ref.read(authService);
  return AuthProvider(as);
});

class AuthProvider extends StateNotifier<Map<String, dynamic>> {
  AuthProvider(this._userProvider) : super({});

  final AuthService? _userProvider;

  Future<Map<String, dynamic>> login(
    String phone,
    String password,
  ) async {
    try {
      print('auth provider ==> login..');
      var result = await _userProvider!.login(phone, password);

      state = result;
      return result;
    } catch (e) {
      print('auth provider ==> login error..');
      throw (e);
    }
  }

  Future<Map<String, dynamic>> register(Map registran) async {
    try {
      print('auth provider ==> register..');
      var result = await _userProvider!.registrasi(registran);

      state = result;
      return result;
    } catch (e) {
      print('auth provider ==> register error..');
      throw (e);
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    try {
      print('auth provider ==> verify otp..');
      var result = await _userProvider!.verifyOtp(phone, otp);

      state = result;
      return result;
    } catch (e) {
      print('auth provider ==> verify otp error..');
      throw (e);
    }
  }

  Future<Map<String, dynamic>> resendOtp(String phone) async {
    try {
      print('auth provider ==> resend otp..');
      var result = await _userProvider!.resednOtp(phone);

      state = result;
      return result;
    } catch (e) {
      print('auth provider ==> resend otp error..');
      throw (e);
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String phone) async {
    try {
      print('auth provider ==> resend otp..');
      var result = await _userProvider!.forgotPassword(phone);

      state = result;
      return result;
    } catch (e) {
      print('auth provider ==> resend otp error..');
      throw (e);
    }
  }

  Future<Map<String, dynamic>> verifyForgotPassword(
      String phone, String otp) async {
    try {
      print('auth provider ==> verifyForgotPassword');
      var result = await _userProvider!.verifyForgotPassword(phone, otp);

      state = result;
      return result;
    } catch (e) {
      print('auth provider ==> verifyForgotPassword error..');
      throw (e);
    }
  }

  Future<Map<String, dynamic>> storeResetPassword(
      String password, String vPassword, String token) async {
    try {
      print('auth provider ==> storeResetPassword');
      var result =
          await _userProvider!.storeResetPassword(password, vPassword, token);

      state = result;
      return result;
    } catch (e) {
      print('auth provider ==> storeResetPassword error..');
      throw (e);
    }
  }

  Future<bool> logout() async {
    try {
      print('user provider ==> loging out..');
      var result = await _userProvider!.removeSessionUser();

      return result;
    } catch (e) {
      throw (e);
    }
  }
}
