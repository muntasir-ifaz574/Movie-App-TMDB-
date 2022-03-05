import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class modified_text extends StatelessWidget {
  final dynamic text;
  final dynamic color;
  final double? size;
  const modified_text({Key? key, this.text, this.size, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        color: color,
        fontSize: size,
      ),
    );
  }
}
