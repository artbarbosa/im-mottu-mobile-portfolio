// ignore_for_file: overridden_fields
import 'base_error.dart';

class AppError extends BaseError {
  @override
  final String message;

  AppError(this.message) : super(message);
}
