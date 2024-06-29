class CharacterListParams {
  final String? name;
  final String? orderBy;

  CharacterListParams({
    this.name,
    this.orderBy,
  });

  String toQueryString() {
    var params = <String, String>{};
    params.putIfAbsent('name', () => name?.toString() ?? '');
    params.putIfAbsent('orderBy', () => orderBy?.toString() ?? '');

    return params.entries
        .where((e) => e.value.isNotEmpty)
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
