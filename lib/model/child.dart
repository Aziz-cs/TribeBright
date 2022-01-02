class Child {
  String childName;
  int age;
  bool isMale;

  Child({
    required this.childName,
    required this.age,
    required this.isMale,
  });

  factory Child.fromRTDB(Map<dynamic, dynamic> data) {
    return Child(
      childName: data['childName'],
      age: data['age'],
      isMale: data['isMale'],
    );
  }

  @override
  String toString() {
    return "Child's name is $childName\nAge: $age\IsMale: $isMale";
  }
}
