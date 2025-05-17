import '../lib/data/dao/ai/generator/death_quote_generator.dart';
import '../lib/data/dao/ai/generator/news_generator.dart';

void main() async {
  final deathGen = DeathQuoteGenerator();

  final deathQuote = await deathGen.generate({
    'characterName': 'Tonio',
    'role': 'Fighter',
    'causeOfDeath': 'Gun',
  });

  final newsGen = NewsGenerator();

  final news = await newsGen.generate({
    'city': 'San-Bruno',
    'day': '17',
    'events': [
      'The Bravo Clan Takes Over a Bar in the Bronx',
      'Chinese Successfully Robbed a Casino in Downtown',
    ],
  });
  print('-------------------');
  print('Останні слова: $deathQuote');
  print('-------------------');
  print('\n🗞 Новини дня:\n$news');
  print('-------------------');
}
