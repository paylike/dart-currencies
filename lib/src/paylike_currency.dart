/// PaylikeCurrency describes a single currency in the collection
class PaylikeCurrency {
  /// Currency code (e.g. USD, EUR, GBP)
  String code;

  /// Currency name (e.g. United States dollar, Euro, Pound Sterling)
  String currency;

  /// Numeric code for the currency (e.g. 840, 978, 826)
  int numeric;

  /// Exponent to use with a given currency
  int exponent;

  /// Indicates currency support for your merchant account
  bool funding;

  /// Indicates if the given currency is supported yet (e.g. the old Venezuelan bolívar soberan is deprecated now)
  bool deprecated;

  /// Creates a PaylikeCurrency instance
  PaylikeCurrency(this.code, this.currency, this.numeric, this.exponent,
      this.funding, this.deprecated);

  /// Creates a PaylikeCurrency instance using JSON
  PaylikeCurrency.fromJSON(Map<String, dynamic> json)
      : code = json['code'],
        currency = json['currency'],
        numeric = int.parse(json['numeric']),
        exponent = json['exponent'],
        funding = json['funding'] != null,
        deprecated = json['deprecated'] != null;
}
