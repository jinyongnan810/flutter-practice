import 'package:flutter_practice/models/user_id.dart';
import 'package:flutter_practice/models/user_name.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

// class UserConverter implements JsonConverter<UserResponse, Map<String, dynamic>> {
//   const UserConverter();

//   @override
//   UserResponse fromJson(Map<String, dynamic> json) {
//     final id = json['id']['name'] + json['id']['value'];
//     final name =
//         json['name']['title'] + json['name']['title'] + json['name']['title'];
//     final email = json['email'];
//     final phone = json['phone'];
//     return UserResponse(id: id, name: name, email: email, phone: phone);
//   }

//   @override
//   Map<String, dynamic> toJson(UserResponse data) => data.toJson();
// }

@freezed
class User with _$User {
  const factory User({
    required UserId id,
    required UserName name,
    required String email,
    required String phone,
  }) = _User;
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
