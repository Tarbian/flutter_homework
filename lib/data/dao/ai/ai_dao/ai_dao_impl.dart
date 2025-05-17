import 'package:Tests/data/dao/ai/ai_dao/ai_dao.dart';
import 'package:Tests/data/dao/ai/generator/death_quote_generator.dart';
import 'package:Tests/data/dao/ai/generator/news_generator.dart';

class AiDaoImpl extends AiDao {
  @override
  Future<String> getDeathQuote() async {
    final deathGen = DeathQuoteGenerator();

    final deathQuote = await deathGen.generate({
      'characterName': 'Tonio',
      'role': 'Fighter',
      'causeOfDeath': 'Gun',
    });

    return deathQuote;
  }

  @override
  Future<String> getNews() async {
    final newsGen = NewsGenerator();

    final news = await newsGen.generate({
      'city': 'San-Bruno',
      'day': '17',
      'events': [
        'The Bravo Clan Takes Over a Bar in the Bronx',
        'Chinese Successfully Robbed a Casino in Downtown',
      ],
    });
    return news;
  }
}
