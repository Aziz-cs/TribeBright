import 'package:tribebright/model/child.dart';

class Parent {
  String name;
  String phoneNumber;
  List<Child> children;

  Parent({
    required this.name,
    required this.phoneNumber,
    required this.children,
  });

  factory Parent.fromRTDB(Map<dynamic, dynamic> data) {
    return Parent(
      name: data['name'] ?? '',
      phoneNumber: data['phoneNo'] ?? '',
      children: getParentsChildren(data['children'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'Parent name is $name\nParent phone No: $phoneNumber\nParent\'s children is ${children.toString()}';
  }
}

List<Child> getParentsChildren(Map data) {
  List<Child> childrenList = [];
  data.forEach((key, value) {
    childrenList.add(Child.fromRTDB(value));
  });
  return childrenList;
}
