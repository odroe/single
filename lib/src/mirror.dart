import 'dart:mirrors' as mirrors;

import 'annotations.dart';
import 'factory.dart';
import 'single.dart';

SingleFactory<T> createFactoryInMirrors<T extends Object>() {
  final mirrors.InstanceMirror mirror = mirrors.reflect(T);
  if (mirror is! mirrors.ClassMirror) {
    throw ArgumentError('$T must be a class');
  }

  final mirrors.ClassMirror classMirror = mirror as mirrors.ClassMirror;
  if (classMirror.isAbstract) {
    throw ArgumentError('$T must not be abstract');
  }

  final mirrors.InstanceMirror factoryMirror = classMirror.metadata.singleWhere((element) => element.reflectee is SingleMirrorFactory, orElse: () => throw ArgumentError('$T must have a @SingleMirrorFactory() annotation'));
  final SingleMirrorFactory factory = factoryMirror.reflectee as SingleMirrorFactory;

  return <T> () => classMirror.newInstance(Symbol(factory.constructorName), []).reflectee as T;
}

extension FindSingletonInMirror on Single {
  T call<T extends Object>() {
    try {
      return this.call<T>();
    } catch (e) {
      
    }
    // final factory = createFactoryInMirrors<T>();
    // return factory();
  }
}
