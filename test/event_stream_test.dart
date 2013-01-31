library event_stream_test;

import 'package:unittest/unittest.dart';
import 'package:event_stream/event_stream.dart';

void main() {
  group('event_stream tests: ', () {
    setUp(() {
    });
    
    test('Can fire event', () {
      bool v = true;
      expect(v, true);
    });
  });
}
