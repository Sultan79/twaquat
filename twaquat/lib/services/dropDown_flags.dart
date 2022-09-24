import 'dart:convert';

class DropDownFlags {
  String flag1;
  String flag2;
  String flag3;
  DropDownFlags({
    required this.flag1,
    required this.flag2,
    required this.flag3,
  });

  DropDownFlags copyWith({
    String? flag1,
    String? flag2,
    String? flag3,
  }) {
    return DropDownFlags(
      flag1: flag1 ?? this.flag1,
      flag2: flag2 ?? this.flag2,
      flag3: flag3 ?? this.flag3,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'flag1': flag1,
      'flag2': flag2,
      'flag3': flag3,
    };
  }

  factory DropDownFlags.fromMap(Map<String, dynamic> map) {
    return DropDownFlags(
      flag1: map['flag1'] ?? '',
      flag2: map['flag2'] ?? '',
      flag3: map['flag3'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DropDownFlags.fromJson(String source) =>
      DropDownFlags.fromMap(json.decode(source));

  @override
  String toString() =>
      'DorpDownFlags(flag1: $flag1, flag2: $flag2, flag3: $flag3)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropDownFlags &&
        other.flag1 == flag1 &&
        other.flag2 == flag2 &&
        other.flag3 == flag3;
  }

  @override
  int get hashCode => flag1.hashCode ^ flag2.hashCode ^ flag3.hashCode;
}
