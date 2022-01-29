class Child {
  String childName;
  String childID;
  int age;
  bool isMale;

  Child({
    required this.childName,
    required this.childID,
    required this.age,
    required this.isMale,
  });

  factory Child.fromRTDB(Map<dynamic, dynamic> data) {
    return Child(
      childName: data['childName'] ?? '',
      childID: data['childID'] ?? '',
      age: data['age'] ?? 0,
      isMale: data['isMale'] ?? true,
    );
  }

  @override
  String toString() {
    return "Child's name is $childName\nAge: $age\IsMale: $isMale";
  }
}
