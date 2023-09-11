class ErrorResponse {
  int statusCode;
  String statusMessage;

  ErrorResponse({
    required this.statusCode,
    required this.statusMessage,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        statusCode: json["status"],
        statusMessage: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
      };
}
