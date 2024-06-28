extension CustomMapExtension on Map<String, dynamic> {
  bool get isError => this['status'] == 'error';

  String get errorMessage => this['status_msg'];
}
