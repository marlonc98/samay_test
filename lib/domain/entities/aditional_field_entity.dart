enum AditionalFielType { text, number, date, boolean }

class AditionalFieldEntity {
  String name;
  String hint;
  AditionalFielType type;
  bool optional;
  dynamic value;

  AditionalFieldEntity({
    required this.name,
    required this.type,
    this.optional = false,
    this.hint = "",
    this.value,
  });
}
