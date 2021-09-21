import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class AuthenticationResponse {
  String access_token;
  String tokenType;
  String expiresAt;

  AuthenticationResponse(
      {this.access_token = '', this.tokenType = '', this.expiresAt = ''});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
