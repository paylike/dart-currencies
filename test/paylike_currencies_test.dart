import 'package:paylike_currencies/paylike_currencies.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final awesome = PaylikeCurrencies();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });
}
