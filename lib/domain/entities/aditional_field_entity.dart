enum AditionalFielType { text, number, date, boolean }

class AditionalFieldEntity {
  String name;
  AditionalFielType type;
  bool optional;

  AditionalFieldEntity({
    required this.name,
    required this.type,
    this.optional = false,
  });
}
