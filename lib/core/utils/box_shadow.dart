import 'package:flutter/material.dart';
import 'package:ibank/core/utils/appcolour.dart';

BoxShadow getDefaultBoxShadow() {
  return BoxShadow(
    color: AppColours.naturalColor1.withValues(alpha: 0.2),
    blurRadius: 15,
    offset: const Offset(0, 4),
  );
}

BoxShadow getDefaultBoxShadow2() {
  return BoxShadow(
    blurStyle: BlurStyle.outer,
    color: AppColours.naturalColor1.withValues(alpha: 0.2),
    blurRadius: 4,
    offset: const Offset(0, 4),
  );
}
