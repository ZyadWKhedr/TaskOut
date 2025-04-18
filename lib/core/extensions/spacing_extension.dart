import 'package:flutter/material.dart';
import '../utils/app_sizes.dart';

extension SpacingExtension on num {
  /// Horizontal spacing
  SizedBox get w => SizedBox(width: toDouble());

  /// Vertical spacing
  SizedBox get h => SizedBox(height: toDouble());

  /// Spacing relative to screen width
  SizedBox get wRel => SizedBox(width: AppSizes.blockWidth * this);

  /// Spacing relative to screen height
  SizedBox get hRel => SizedBox(height: AppSizes.blockHeight * this);
}
