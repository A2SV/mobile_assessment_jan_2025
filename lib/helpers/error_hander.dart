class ErrorHandler implements Exception {
  final String errorMessage;

  ErrorHandler({required this.errorMessage});

  factory ErrorHandler.fromErrorHandler({required String message}) {
    try {
      return ErrorHandler(errorMessage: message);
    } on Exception catch (_) {
      return ErrorHandler(
        errorMessage: 'Error unrecognized',
      );
    }
  }
}
