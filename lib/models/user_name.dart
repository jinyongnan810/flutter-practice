import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user_name.freezed.dart';
part 'user_name.g.dart';

@freezed
class UserName with _$UserName {
  const factory UserName({
    required String title,
    required String first,
    required String last,
  }) = _UserName;
  factory UserName.fromJson(Map<String, Object?> json) =>
      _$UserNameFromJson(json);
}
