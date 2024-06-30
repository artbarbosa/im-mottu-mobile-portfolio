class CharacterListParams {
  final String? nameStartsWith;
  final String? orderBy;
  final int? limit;
  final int? offset;

  CharacterListParams({
    this.nameStartsWith,
    this.orderBy,
    this.limit,
    this.offset,
  });

  String toQueryString() {
    var params = <String, dynamic>{};
    params.putIfAbsent(
        'nameStartsWith', () => nameStartsWith?.toString() ?? '');
    params.putIfAbsent('orderBy', () => orderBy?.toString() ?? '');
    params.putIfAbsent('limit', () => limit.toString());
    params.putIfAbsent('offset', () => offset.toString());

    return params.entries
        .where((e) => e.value.isNotEmpty)
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  CharacterListParams copyWith({
    String? nameStartsWith,
    String? orderBy,
    int? limit,
    int? offset,
  }) {
    return CharacterListParams(
      nameStartsWith: nameStartsWith ?? this.nameStartsWith,
      orderBy: orderBy ?? this.orderBy,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}
