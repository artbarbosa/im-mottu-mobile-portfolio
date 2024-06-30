class CharacterListParams {
  final String? nameStartsWith;
  final String? orderBy;

  CharacterListParams({
    this.nameStartsWith,
    this.orderBy,
  });

  String toQueryString() {
    var params = <String, String>{};
    params.putIfAbsent(
        'nameStartsWith', () => nameStartsWith?.toString() ?? '');
    params.putIfAbsent('orderBy', () => orderBy?.toString() ?? '');

    return params.entries
        .where((e) => e.value.isNotEmpty)
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
