import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:paylike_currencies/paylike_currencies.dart';
import 'package:source_gen/source_gen.dart';

Builder currencyBuilder(BuilderOptions options) =>
    LibraryBuilder(CurrencyGenerator(), generatedExtension: '.currency.g.dart');

/// Generates currency collection
class CurrencyGenerator extends Generator {
  const CurrencyGenerator();
  @override
  Future<String> generate(LibraryReader library, BuildStep step) async {
    var f = File('./lib/src/currencies.json');
    var raw = f.readAsStringSync();
    List<dynamic> currencies = jsonDecode(raw);

    final outputEnum = <String>[
      '''enum CurrencyCode {

        '''
    ];
    final outputClass = <String>[
      '''class PaylikeCurrencyCollection {
          static final Map<CurrencyCode, PaylikeCurrency> currencies = {
      
      '''
    ];
    for (var currency in currencies) {
      var parsed = PaylikeCurrency.fromJSON(currency);
      outputEnum.add('''
      ${parsed.code},
      ''');
      outputClass.add('''
        CurrencyCode.${parsed.code}: PaylikeCurrency('${parsed.code}', '${parsed.currency}', ${parsed.numeric}, ${parsed.exponent}, ${parsed.funding}),
      ''');
    }

    outputEnum.add('}');
    outputClass.add('};}');

    return '''
    import 'package:paylike_currencies/paylike_currencies.dart';

    ${outputEnum.join('')}
    ${outputClass.join('')}
    ''';
  }
}
