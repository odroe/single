import 'package:single/single.dart';

class MyClass1 {
  say() {
    print('😊 Happy matryoshk!!!');
  }
}

class MyClass2 {
  final MyClass1 myClass1;

  MyClass2(this.myClass1);
}

void main_1() {
  // register MyClass1
  single + () => MyClass1();

  // register MyClass2
  single + () => MyClass2(single<MyClass1>());

  // get MyClass2
  final MyClass2 myClass2 = single();

  // call say
  myClass2.myClass1.say();
}

/// --------------------------------------------------
/// Custom finder
/// --------------------------------------------------

class MyFinder implements SingleFinder {
  @override
  SingleFactory<T>? call<T extends Object>() {
    if (T == MyClass1) {
      return () => MyClass1() as T;
    }
  }
}

void main_2() {
  // Register MyFinder
  single | MyFinder();

  // Get MyClass1
  final MyClass1 myClass1 = single();

  myClass1.say();
}
