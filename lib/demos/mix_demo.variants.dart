import 'package:mix/mix.dart';

class ButtonSize extends Variant {
  const ButtonSize._(super.name);
  // Sizes
  static const small = ButtonSize._('button.small');
  static const medium = ButtonSize._('button.medium');
  static const large = ButtonSize._('button.large');

  static const values = [
    small,
    medium,
    large,
  ];
}

class ButtonType extends Variant {
  const ButtonType._(super.name);
  // Types
  static const primary = ButtonType._('button.primary');
  static const secondary = ButtonType._('button.secondary');
  static const warning = ButtonType._('button.warning');
  static const danger = ButtonType._('button.danger');
  static const outline = ButtonType._('button.outline');

  static const values = [
    primary,
    secondary,
    warning,
    danger,
    outline,
  ];
}
