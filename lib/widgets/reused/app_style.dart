import 'dart:ui';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyle(double size, Color color, FontWeight fontWeight) {
  return GoogleFonts.poppins(
      fontSize: size.sp, color: color, fontWeight: fontWeight);
}
