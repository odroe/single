import 'single.dart';

@SingleMirrorFactory()
class Test {}

main() {
  final Test test = single();

  print(test);
}
