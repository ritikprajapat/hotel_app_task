import 'package:google_sign_in/google_sign_in.dart';
import '../../../app/app.dart';

class LoginViewModel extends ChangeNotifier {
  final GoogleSignIn _googleSignIn;
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  LoginViewModel({GoogleSignIn? googleSignIn}) : _googleSignIn = googleSignIn ?? GoogleSignIn();

  bool get isLoading => _isLoading;
  bool get isGoogleLoading => _isGoogleLoading;

  void _setLoading({bool google = false, required bool value}) {
    if (google) {
      _isGoogleLoading = value;
    } else {
      _isLoading = value;
    }
    notifyListeners();
  }

  void _showSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF151515),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _navigateToHome(BuildContext context) async {
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, '/home');
  }

  Future<void> handleContinue(BuildContext context) async {
    _setLoading(value: true);

    try {
      final resp = await ApiService.registerDeviceResponse();

      if (resp != null && resp.responseCode == 201) {
        await _navigateToHome(context);
      } else {
        _showSnackBar(context, 'Device registration failed. Please try again.');
      }
    } catch (e) {
      _showSnackBar(context, 'Something went wrong: ${e.toString()}');
    } finally {
      _setLoading(value: false);
    }
  }

  Future<void> handleGoogleSignIn(BuildContext context) async {
    _setLoading(google: true, value: true);

    try {
      final account = await _googleSignIn.signIn();
      await Future.delayed(const Duration(milliseconds: 300));

      if (account == null) {
        _showSnackBar(context, 'Sign-in cancelled.');
        return;
      }

      _showSnackBar(
        context,
        'Signed in as ${account.displayName ?? account.email}',
      );

      final resp = await ApiService.registerDeviceResponse();

      if (resp != null && resp.responseCode == 201) {
        await _navigateToHome(context);
      } else {
        _showSnackBar(context, 'Device registration failed. Please try again.');
      }
    } catch (e) {
      _showSnackBar(context, 'Google Sign-In failed: ${e.toString()}');
    } finally {
      _setLoading(google: true, value: false);
    }
  }
}
