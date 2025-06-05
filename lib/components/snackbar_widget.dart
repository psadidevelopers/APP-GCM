import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_gcm_sa/utils/estilos.dart';

void showCustomSnackbar(
  BuildContext context, {
  required String message,
  Color backgroundColor = Estilos.success,
  Color textColor = Estilos.textSuccess,
  Duration duration = const Duration(seconds: 4),
}) {
  ScaffoldMessenger.of(context).clearSnackBars(); // Clear previous snackbars

  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: backgroundColor,
    duration: duration,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    content: Text(
      message,
      style: GoogleFonts.getFont(
        'Nunito',
        color: textColor,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
