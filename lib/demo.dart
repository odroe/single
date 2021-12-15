import 'dart:mirrors' as mirrors;

class SingleMirror {
  final String factory;

  const SingleMirror([this.factory = ""]);
}

@SingleMirror()
class Demo {
  const Demo();

  run() {}

  @override
  String toString() {
    return 'xxxxxx';
  }

  static demo() {}

  static int a = 1;

  factory Demo.haha() {
    return Demo();
  }
}

find<T>() {
  final mirrors.ClassMirror value = mirrors.reflectClass(T);
  final SingleMirror a = value.metadata.singleWhere((element) => element.reflectee is SingleMirror).reflectee;

  print(value.newInstance(Symbol(a.factory), []).reflectee);
  // print(value.declarations[Symbol(type.toString())]);
  // final mirrors.MethodMirror b = value.declarations[Symbol(type.toString())]! as mirrors.MethodMirror;
}

main() {
  find<Demo>();
}