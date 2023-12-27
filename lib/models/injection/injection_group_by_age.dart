import '../age/age.dart';
import 'injection.dart';

class InjectionGroupByAge {

  final Age age;
  final List<Injection>? injections;

  InjectionGroupByAge({
    required this.age,
    this.injections
  });

  InjectionGroupByAge copyWith({
    Age? age,
    List<Injection>? injections,

  }) {
    return InjectionGroupByAge(
      age: age ?? this.age,
      injections: injections ?? this.injections,
    );
  }

  set injections(List<Injection>? i) {
    injections = i;
  }


}