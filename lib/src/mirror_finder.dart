import 'dart:mirrors' as mirrors;

import 'annotations.dart';
import 'single.dart' as _single;

_single.SingleFactory<T> createFactoryInMirrors<T extends Object>() {
  final mirrors.InstanceMirror mirror = mirrors.reflect(T);
  if (mirror is! mirrors.ClassMirror) {
    throw ArgumentError('$T must be a class');
  }

  final mirrors.ClassMirror classMirror = mirror as mirrors.ClassMirror;
  if (classMirror.isAbstract) {
    throw ArgumentError('$T must not be abstract');
  }

  final mirrors.InstanceMirror factoryMirror = classMirror.metadata.singleWhere(
      (element) => element.reflectee is SingleMirrorFactory,
      orElse: () => throw ArgumentError(
          '$T must have a @SingleMirrorFactory() annotation'));
  final SingleMirrorFactory factory =
      factoryMirror.reflectee as SingleMirrorFactory;

  return <T>() => classMirror
      .newInstance(Symbol(factory.constructorName), []).reflectee as T;
}

class _SingleMirrorFinder extends _single.SingleFinder {
  @override
  _single.SingleFactory<T>? call<T extends Object>() {
    try {
      return createFactoryInMirrors<T>();
    } catch (e) {
      return null;
    }
  }
}

_single.Single createSingle() {
  _single.single | _SingleMirrorFinder();

  return _single.single;
}

_single.Single single = createSingle();
