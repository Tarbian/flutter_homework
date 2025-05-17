import '../../data/repository/city_repository/city_repository.dart';

class GetNewsUseCase {
  final CityRepository cityRepository;

  GetNewsUseCase(this.cityRepository);

  Future<String> execute() => cityRepository.getNews();
}
