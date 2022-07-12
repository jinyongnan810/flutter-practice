import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user_id.freezed.dart';
part 'user_id.g.dart';

@freezed
class UserId with _$UserId {
  const factory UserId({
    required String name,
    required String value,
  }) = _UserId;
  factory UserId.fromJson(Map<String, Object?> json) => _$UserIdFromJson(json);
}
