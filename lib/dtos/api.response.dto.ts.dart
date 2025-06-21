class ApiResponse {
  dynamic data;
  String? message;
  int? code;
  bool isSuccessful;

  ApiResponse({
    required this.data,
    required this.message,
    required this.code,
    this.isSuccessful = false,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final message = json["message"];

    String? parsedMessage;
    if (message == null) {
      parsedMessage = null;
    } else if (message is String) {
      parsedMessage = message;
    } else if (message is Map &&
        json["code"] == 400 &&
        message["message"] is List) {
      parsedMessage = (message["message"] as List<dynamic>)
          .map((e) => e.toString())
          .join(", ");
    } else if (message is List) {
      parsedMessage = (message).map((e) => e.toString()).join(", ");
    } else {
      parsedMessage = message.toString();
    }

    return ApiResponse(
      data: json["data"],
      code: json["code"] ?? 400,
      isSuccessful: json["code"] == 200 || json["code"] == 201,
      message: parsedMessage,
    );
  }
}
