import 'package:Tests/data/dao/ai/ai_dao/ai_dao.dart';
import 'package:Tests/data/dao/ai/ai_dao/ai_dao_impl.dart';
import 'package:Tests/data/repository/city_repository/city_repository.dart';
import 'package:Tests/data/repository/city_repository/city_repository_impl.dart';
import 'package:Tests/domain/use_cases/get_news_use_case.dart';
import 'game_presenter.dart';

class GameInitialiser {
  GamePresenter getGamePresenter() {
    AiDao aiDao = AiDaoImpl();
    CityRepository cityRepository = CityRepositoryImpl(aiDao);
    GetNewsUseCase getNewsUseCase = GetNewsUseCase(cityRepository);
    return GamePresenter(getNewsUseCase: getNewsUseCase);
  }
}
