library event_stream_test;

import 'package:unittest/unittest.dart';
import 'package:event_stream/event_stream.dart';

import 'dart:async';

void main() {
  group('event_stream tests: ', () {
    setUp(() {
    });
    
    test('Can fire event', () {
      bool eventFired = false;
      bool propertyChangeFired = false;
      var c = new ClassWithEvents();
      c.onPropertyChanged.listen((PropertyChangedEventArgs<String> args) => propertyChangeFired = true);
      c.onClosed.listen((_) => eventFired = true);
      c.someProperty = "test";
      c.close();
      
      expect(propertyChangeFired, true);
      expect(eventFired, true);
    });
  });
}

class ClassWithEvents implements NotifyPropertyChanged {
  String _someProperty;
  
  final EventStream<PropertyChangedEventArgs> _onPropertyChangedEvent = new EventStream<PropertyChangedEventArgs>();
  Stream<PropertyChangedEventArgs> get onPropertyChanged => _onPropertyChangedEvent.stream;
  
  final EventStream _onClosedEvent = new EventStream();
  Stream get onClosed => _onClosedEvent.stream;
  
  String get someProperty => _someProperty;
  set someProperty(String value) {
    _someProperty = value;
    _onPropertyChangedEvent.signal(new PropertyChangedEventArgs('someProperty', value));
  }
  
  close() {
    _onClosedEvent.signal();
  }
}
