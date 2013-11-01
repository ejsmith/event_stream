library event_stream_test;

import 'package:unittest/unittest.dart';
import 'package:event_stream/event_stream.dart';

import 'dart:async';

void main() {
  group('event_stream tests: ', () {
    test('Can fire event', () {
      var c = new ClassWithEvents();
      c.onPropertyChanged.listen(expectAsync1((_) {}));
      c.onClosed.listen(expectAsync1((_) {}));
      c.someProperty = "test";
      c.close();
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
