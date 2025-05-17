import '../../dao/ai/ai_dao/ai_dao.dart';
import 'city_repository.dart';

class CityRepositoryImpl implements CityRepository {
  final AiDao aiDao;

  CityRepositoryImpl(this.aiDao);

  @override
  Future<String> getNews() async => aiDao.getNews();
}
