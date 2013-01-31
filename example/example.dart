import 'package:event_stream/event_stream.dart';

import 'dart:async';

class ClassWithEvents implements NotifyPropertyChanged {
  String _someProperty;
  String _someOtherProperty;
  int _someIntProperty;
  
  final EventStream<PropertyChangedEventArgs> _onPropertyChangedEvent = new EventStream<PropertyChangedEventArgs>();
  Stream<PropertyChangedEventArgs> get onPropertyChanged => _onPropertyChangedEvent.stream;
  
  final EventStream _onClosedEvent = new EventStream();
  Stream get onClosed => _onClosedEvent.stream;
  
  String get someProperty => _someProperty;
  set someProperty(String value) {
    _someProperty = value;
    _onPropertyChangedEvent.signal(new PropertyChangedEventArgs('someProperty', value));
  }
  
  String get someOtherProperty => _someOtherProperty;
  set someOtherProperty(String value) {
    _someOtherProperty = value;
    _onPropertyChangedEvent.signal(new PropertyChangedEventArgs('someOtherProperty', value));
  }
  
  int get someIntProperty => _someIntProperty;
  set someIntProperty(int value) {
    _someIntProperty = value;
    _onPropertyChangedEvent.signal(new PropertyChangedEventArgs('someIntProperty', value));
  }
  
  close() {
    _onClosedEvent.signal();
  }
}

main() {
  var c = new ClassWithEvents();
  c.onPropertyChanged.listen((PropertyChangedEventArgs<String> args) => print('listen1: name=${args.propertyName} value=${args.value} type=${args.value.runtimeType}'));
  c.onPropertyChanged.listen((PropertyChangedEventArgs<String> args) => print('listen2: name=${args.propertyName} value=${args.value} type=${args.value.runtimeType}'));
  c.onClosed.listen((_) => print('closed1'));
  c.onClosed.first.whenComplete(() => print('first closed'));
  c.someProperty = "test1";
  c.someOtherProperty = "test1";
  c.someProperty = "test2";
  c.someOtherProperty = "test2";
  c.someIntProperty = 1;
  c.close();
  c.close();
}