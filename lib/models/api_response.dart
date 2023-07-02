class ApiResponse<T> {
  final bool success;
  final T? data;
  final List<String>? errors;
  ApiResponse({
    required this.success,
    this.data,
    this.errors,
  });
}
