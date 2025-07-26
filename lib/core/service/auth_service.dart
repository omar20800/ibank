import 'dart:developer';
import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> checkBiometricSupport() async {
    try {
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      bool isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheckBiometrics && isDeviceSupported;
    } catch (e) {
      log('Biometric support check error: $e');
      return false;
    }
  }

  Future<bool> authenticateWithBiometrics(String message) async {
    try {
      bool supported = await checkBiometricSupport();
      if (!supported) {
        log("Biometric not supported on this device.");
        return false;
      }

      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: message,
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );

      return isAuthenticated;
    } catch (e) {
      log('Biometric auth error: $e');
      return false;
    }
  }
}
