class RequestCallbacks {
  final void Function(dynamic response) onSuccess;
  final void Function(String errorMessage) onError;

  RequestCallbacks({
    required this.onSuccess,
    required this.onError,
  });
}