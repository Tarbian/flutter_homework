import '../death_quote_generator.dart';

abstract class DeathQuoteRepository {
  String getDeathQuote();
}

class DeathQuoteRepositoryImpl implements DeathQuoteRepository {
  final DeathQuoteGenerator DeathQuote;

  DeathQuoteRepositoryImpl(this.DeathQuote);

  @override
  String getDeathQuote() => DeathQuote.generate();
}
