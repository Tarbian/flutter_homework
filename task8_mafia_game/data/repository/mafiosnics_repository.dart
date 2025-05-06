import '../../domain/entities/mafiosnic.dart';
import '../mock_mafiosnics_dao.dart';

abstract class MafiosnicsRepository {
  List<Mafiosnic> getMafiosnicList();
}

class MafiosnicsRepositoryImpl implements MafiosnicsRepository {
  final MockMafiosnicsDao mockDao;

  MafiosnicsRepositoryImpl(this.mockDao);

  @override
  List<Mafiosnic> getMafiosnicList() => mockDao.getAll();
}
