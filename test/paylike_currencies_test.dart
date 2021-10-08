import 'package:paylike_currencies/paylike_currencies.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final currencies = PaylikeCurrencies();
    test('Should be able to find PaylikeCurrency based on code', () {
      var currency = currencies.byCode(CurrencyCode.EUR);
      expect(currency.code, 'EUR');
      expect(currency.currency, 'Euro');
      expect(currency.numeric, 978);
      expect(currency.exponent, 2);
      expect(currency.funding, true);
    });

    test('toMajor toMinor should work as expected', () {
      expect(currencies.toMajor(CurrencyCode.EUR, 100), 1.00);
      expect(currencies.toMinor(CurrencyCode.EUR, 1), 100);
      expect(currencies.toMajor(CurrencyCode.JPY, 1), 1);
      expect(currencies.toMinor(CurrencyCode.JPY, 1), 1);
      expect(currencies.toMajor(CurrencyCode.JPY, 0), 0);
      expect(currencies.toMinor(CurrencyCode.JPY, 0), 0);

      expect(currencies.toMinor(CurrencyCode.EUR, 19.9), 1990);
      expect(currencies.toMinor(CurrencyCode.EUR, 19.99), 1999);
      expect(currencies.toMinor(CurrencyCode.EUR, 19.01), 1901);

      try {
        currencies.byNumeric(2355);
        fail('should not be able to reach this');
      } catch (e) {
        expect(e is MissingCurrencyException, true);
        expect((e as MissingCurrencyException).numeric, 2355);
      }
      try {
        currencies.getCurrencyCode('EURO');
        fail('should not be able to reach this');
      } catch (e) {
        expect(e is MissingCurrencyException, true);
        expect((e as MissingCurrencyException).requestCode, 'EURO');
      }
    });
  });
}
