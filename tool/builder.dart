import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:paylike_currencies/src/paylike_currency.dart';
import 'package:source_gen/source_gen.dart';

// @nodoc
Builder currencyBuilder(BuilderOptions options) =>
    LibraryBuilder(CurrencyGenerator(), generatedExtension: '.currency.g.dart');

/// Generates currency collection
/// @nodoc
class CurrencyGenerator extends Generator {
  const CurrencyGenerator();
  @override
  Future<String> generate(LibraryReader library, BuildStep step) async {
    var f = File('./lib/src/currencies.json');
    var raw = f.readAsStringSync();
    List<dynamic> currencies = jsonDecode(raw);

    final outputEnum = <String>[
      '''/// Code used when referencing a currency
enum CurrencyCode {

        '''
    ];
    final outputClass = <String>[
      '''/// Collection of all available currencies by [CurrencyCode]
class PaylikeCurrencyCollection {
          static final Map<CurrencyCode, PaylikeCurrency> currencies = {
      
      '''
    ];
    for (var currency in currencies) {
      var parsed = PaylikeCurrency.fromJSON(currency);
      outputEnum.add('''
      ${parsed.code},
      ''');
      outputClass.add('''
        CurrencyCode.${parsed.code}: PaylikeCurrency('${parsed.code}', '${parsed.currency}', ${parsed.numeric}, ${parsed.exponent}, ${parsed.funding}, ${parsed.deprecated}),
      ''');
    }

    outputEnum.add('}');
    outputClass.add('};}');

    return '''
    import 'package:paylike_currencies/src/paylike_currency.dart';

    ${outputEnum.join('')}
    ${outputClass.join('')}
    ''';
  }
}
