import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

/// Central state for the portfolio app.
///
/// Manages:
/// - **navIndex**: which header nav item is active (0–4)
/// - **isLoading**: whether an email is being sent
/// - **contact-form controllers**: name, email, message
class PortfolioProvider extends ChangeNotifier {
  // ── Navigation ──────────────────────────────────────────────────
  int _navIndex = 4;
  int get navIndex => _navIndex;
  void setNavIndex(int index) {
    if (_navIndex != index) {
      _navIndex = index;
      notifyListeners();
    }
  }

  // ── Loading state ───────────────────────────────────────────────
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  // ── Contact-form controllers ────────────────────────────────────
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  // ── Email logic ─────────────────────────────────────────────────

  /// Validates contact form fields. Returns an error message or null if valid.
  String? _validate() {
    if (nameController.text.isEmpty) return 'Write your name to send...';
    if (emailController.text.isEmpty) return 'Write your email to send...';
    if (!emailController.text.contains("@gmail.com")) return 'Invalid Email.';
    if (messageController.text.isEmpty) return 'Write a message to send...';
    return null;
  }

  /// Sends an email via mailto: URI after validating the form.
  ///
  /// [fontSize] controls snackbar text size (e.g. 7.sp for desktop, 15.sp for mobile).
  Future<void> sendEmail(BuildContext context,
      {required double fontSize}) async {
    final error = _validate();
    if (error != null) {
      _showSnackBar(context, error, Colors.redAccent, fontSize);
      return;
    }

    try {
      setLoading(true);
      final subject = "Message From Portfolio By ${nameController.text}";
      final body = "From: ${emailController.text}\n\n${messageController.text}";
      final mailUri = Uri(
        scheme: 'mailto',
        path: 'ramadan.work010@gmail.com',
        queryParameters: {'subject': subject, 'body': body},
      );
      final launched =
          await launchUrl(mailUri, mode: LaunchMode.externalApplication);
      if (!launched) throw 'Could not open the email app';

      setLoading(false);
      if (context.mounted) {
        _showSnackBar(context, 'Message sent successfully.', Colors.greenAccent,
            fontSize);
      }
      nameController.clear();
      emailController.clear();
      messageController.clear();
    } catch (e) {
      setLoading(false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text('Failed to send email: $e')),
        );
      }
    }
  }

  void _showSnackBar(
      BuildContext context, String message, Color color, double fontSize) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: CustomColor.scaffoldColor,
        content: Center(
          child: Text(
            message,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
        ),
      ),
    );
  }

  // ── Disposal ────────────────────────────────────────────────────
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
