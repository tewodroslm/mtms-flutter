import 'package:json_annotation/json_annotation.dart';
import 'package:mtms/models/driver.dart';

part 'auth_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthenticationResponse {
  final String access_token;
  final Driver driver;

  const AuthenticationResponse({
    required this.access_token,
    required this.driver,
  });

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
