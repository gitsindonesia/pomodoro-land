import 'dart:convert';

class RefreshResponse {
  RefreshResponse({
    required this.authToken,
    required this.refresh,
  });

  final String? authToken;
  final String? refresh;

  Map<String, dynamic> toMap() {
    return {
      'auth_token': authToken,
      'refresh': refresh,
    };
  }

  factory RefreshResponse.fromMap(Map<String, dynamic> map) {
    return RefreshResponse(
      authToken: map['auth_token'],
      refresh: map['refresh'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RefreshResponse.fromJson(String source) =>
      RefreshResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RefreshResponse &&
        other.authToken == authToken &&
        other.refresh == refresh;
  }

  @override
  int get hashCode => authToken.hashCode ^ refresh.hashCode;
}
