# Currencies

This library is a clone of the [JS version](https://github.com/paylike/currencies)

List of currencies supported by Paylike for transactions and accounts.

Read more:

- https://paylike.io/account/currency
- https://paylike.io/transactions/currencies

## Account currencies

These are the currencies you can use as a base for your account. Also known as
account, settlement and funding currency.

### Global

- EUR (Euro)
- USD (United States dollar)
- GBP (British pound sterling)

### Nordic

- DKK (Danish krone)
- NOK (Norwegian krone)
- SEK (Swedish krona)

### Other EU

- CHF (Swiss franc)
- HUF (Hungarian forint)
- PLN (Polish złoty)
- RON (Romanian leu)
- CZK (Czech koruna)
- BGN (Bulgarian lev)
- HRK (Croatian kuna)

## Usage

Within the Paylike ecosystem you should use the `CurrencyCode` enum to refer to a currency.

```dart
var currencies = PaylikeCurrencies();
var eur = currencies.byCode(CurrencyCode.EUR);

// lookup by code
currencies.byCode(CurrencyCode.AED);
	// { code: 'AED', currency: 'United Arab Emirates dirham', numeric: '784' }

// lookup CurrencyCode
currencies.getCurrencyCode('EUR');
	// CurrencyCode.EUR

// get List<PaylikeCurrency>
currencies.list();

// Convert between minor and major respecting the exponent
currencies.toMinor(CurrencyCode.DKK, 100.00);
	// 10000

currencies.toMajor(CurrencyCode.DKK, 10000);
	// 100.00
```
