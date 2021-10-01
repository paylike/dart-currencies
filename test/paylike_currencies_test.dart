import 'dart:convert';

import 'package:paylike_currencies/paylike_currencies.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final currencies = PaylikeCurrencies();

    setUp(() {
      // Additional setup goes here.
    });

    test('Should be able to find PaylikeCurrency based on code', () {
      var currency = currencies.byCode(CurrencyCode.EUR);
      expect(currency.code, 'EUR');
      expect(currency.currency, 'Euro');
      expect(currency.numeric, 978);
      expect(currency.exponent, 2);
    });
  });
}
