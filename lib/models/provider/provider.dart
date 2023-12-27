class Provider {
  final int id;
  final String name;

  Provider({
    required this.id,
    required this.name,

  });

  Provider copyWith({
    int? id,
    String? name,

  }) {
    return Provider(
      id: id ?? this.id,
      name: name ?? this.name,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,

    };
  }

  static Provider fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'],
      name: json['name'],

    );
  }

  static List<Provider> parseProvidersList(List<dynamic> jsonList) {
    return jsonList.map((json) => Provider.fromJson(json)).toList();
  }
}
