import 'package:Tests/data/dao/mock/mock_dao.dart';
import 'package:Tests/domain/entities/mafiosnic.dart';

class MockDaoImpl extends MockDao {
  @override
  Future<List<Mafiosnic>> getMafiosnics() async => [
        Mafiosnic("Томмі", Role.fighter,
            strength: 90, iq: 50, luck: 40, skill: 20, loyalty: 80),
        Mafiosnic("Лючія", Role.financier,
            strength: 20, iq: 95, luck: 60, skill: 40, loyalty: 85),
        Mafiosnic("Ніко", Role.hacker,
            strength: 30, iq: 85, luck: 95, skill: 35, loyalty: 70),
        Mafiosnic("Маріо", Role.medic,
            strength: 25, iq: 75, luck: 30, skill: 90, loyalty: 60),
      ];
}
