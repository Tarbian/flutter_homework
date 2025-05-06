
import '../data/death_quote_generator.dart';
import '../data/news_generator.dart';
import '../data/repository/mafiosnics_repository.dart';
import 'entities/mafiosnic.dart';

class GetAllMafiosnicsUseCase {
  final MafiosnicsRepositoryImpl repository;

  GetAllMafiosnicsUseCase(this.repository);

  List<Mafiosnic> execute() {
    return repository.getMafiosnicList();
  }
}


class GenerateDeathQuoteUseCase {
  final DeathQuoteGenerator generator;

  GenerateDeathQuoteUseCase(this.generator);

  String execute() {
    return generator.generate();
  }
}


class GenerateNewsUseCase {
  final NewsGenerator generator;

  GenerateNewsUseCase(this.generator);

  String execute() {
    return generator.generate();
  }
}
