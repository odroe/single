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

void main() {
  // register MyClass1
  single + () => MyClass1();

  // register MyClass2
  single + () => MyClass2(single<MyClass1>());

  // get MyClass2
  final myClass2 = single<MyClass2>();

  // call say
  myClass2.myClass1.say();
}
