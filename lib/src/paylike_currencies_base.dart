import 'package:paylike_currencies/paylike_currencies.dart';
import 'dart:math';

// Describes that a given currency the user is looking for
// is missing from the collection
class MissingCurrencyException implements Exception {
  final String cause = 'Currency is missing';
  CurrencyCode? code;
  int? numeric;
  String? requestCode;
  MissingCurrencyException.fromNumeric(this.numeric);
  MissingCurrencyException.fromCode(this.code);
  MissingCurrencyException.fromStringCode(this.requestCode);
}

// PaylikeCurrencies is responsible for currency related operations
class PaylikeCurrencies {
  // Returns the CurrencyCode based on [code]
  CurrencyCode getCurrencyCode(String code) {
    return PaylikeCurrencyCollection.currencies.entries
        .firstWhere((element) => element.value.code == code,
            orElse: () => throw MissingCurrencyException.fromStringCode(code))
        .key;
  }

  // Provides a [PaylikeCurrency] based on [code]
  PaylikeCurrency byCode(CurrencyCode code) {
    var element = PaylikeCurrencyCollection.currencies[code];
    if (element == null) {
      throw MissingCurrencyException.fromCode(code);
    }
    return element;
  }

  // Lists all available currencies
  List<PaylikeCurrency> list() => List.from(
      PaylikeCurrencyCollection.currencies.entries.map((e) => e.value));

// Provides a [PaylikeCurrency] based on [numeric]
  PaylikeCurrency byNumeric(int numeric) {
    var element = PaylikeCurrencyCollection.currencies.entries.firstWhere(
        (element) => element.value.numeric == numeric,
        orElse: () => throw MissingCurrencyException.fromNumeric(numeric));
    return element.value;
  }

  // Converts a currency to minor value using its exponent
  // e.g: 1 USD to cents
  num toMinor(CurrencyCode code, num major) =>
      (major * pow(10, byCode(code).exponent)).round();

  // Converts a currency to major value using its exponent
  // e.g: 100 cents to 1 USD
  num toMajor(CurrencyCode code, num minor) =>
      minor / pow(10, byCode(code).exponent);
}
