import 'dart:math';

const int maxClanMembers = 4;
const int winReward = 50000;
const int bossWinChance = 65;
const List<String> roles = ['boss', 'member'];

class Mafiosnic {
  final String name;
  final String role; // 'boss' / 'member'

  Mafiosnic(this.name, this.role) {
    if (name.isEmpty) {
      throw ArgumentError('Name can not be empty!');
    }
    if (!roles.contains(role)) { 
      throw ArgumentError('Role must be "boss" or "member"!');
    }
  }

  bool fight(Mafiosnic opponent) {
    if (role == 'boss' && opponent.role == 'member') {
      return Random().nextInt(100) < bossWinChance;
    }
    if (opponent.role == 'boss' && role == 'member') {
      return Random().nextInt(100) < (100 - bossWinChance);
    }
    return Random().nextBool();
  }

  @override
  String toString() => "$name ($role)";
}

class MafiaClan {
  final String name;
  final List<Mafiosnic> members = [];
  int balance = 0;

  MafiaClan(this.name, Mafiosnic boss) {
    if (name.isEmpty) {
      throw ArgumentError('Clan name cannot be empty!');
    }
    if (boss.role != 'boss') {
      throw ArgumentError('A clan must have a boss');
    }
    members.add(boss);
  }

  void addMember(Mafiosnic mafiosnic) {
    if (members.length < maxClanMembers) {
      members.add(mafiosnic);
    } else {
      print(
          "Maximum number of members in a clan - $maxClanMembers\n${mafiosnic.name} cannot be added");
    }
  }

  void shuffleMembers() {
    members.shuffle();
  }

  @override
  String toString() => "$name: ${members.join(', ')} (Balance: \$${balance})";
}

void main() {
  print("~MAKING CLANS~");
  var northClan = MafiaClan('North London Clan', Mafiosnic('John', 'boss'));
  northClan.addMember(Mafiosnic('Dale', 'member'));
  northClan.addMember(Mafiosnic('Gena', 'member'));
  northClan.addMember(Mafiosnic('Bob', 'member'));
  northClan.addMember(Mafiosnic('Steve', 'member'));
  northClan.shuffleMembers();

  var southClan = MafiaClan('South London Clan', Mafiosnic('Mike', 'boss'));
  southClan.addMember(Mafiosnic('Boris', 'member'));
  southClan.addMember(Mafiosnic('Ashly', 'member'));
  southClan.addMember(Mafiosnic('Drake', 'member'));
  southClan.shuffleMembers();
  print("---------------------------");
  print(northClan);
  print("---------------------------");
  print(southClan);
  print("---------------------------");
  print("~FIGHT~");
  while (northClan.members.isNotEmpty && southClan.members.isNotEmpty) {
    var attacker = northClan.members.first;
    var defender = southClan.members.first;

    print("$attacker fight with $defender");

    if (attacker.fight(defender)) {
      print("$attacker wins");
      southClan.members.remove(defender);
    } else {
      print("$defender wins");
      northClan.members.remove(attacker);
    }

    print(northClan);
    print(southClan);
    print("---------------------------");
  }

  if (northClan.members.isNotEmpty) {
    print("North London Clan wins the raid!");
    northClan.balance += winReward;
  } else {
    print("South London Clan wins the raid!");
    southClan.balance += winReward;
  }

  print(northClan);
  print(southClan);
}


// Мафія

// Організувати додаток, в якому клани мафії з північного Лондона будуть воювати з кланами південного.

// Мафія може збиратися в групи та цими групами влаштовувати рекет різних районів іншої частини Лондона.

// В групі обовʼязково має бути мафіозник - ватажок.

// Коли група влаштовує рекет, то їй на зустріч йде група мафії з іншого району

// Починається перестрілка, де кожен учасник групи виходить з учасником іншої групи один на один. З вірогідністю 50 на 50 хтось один з них вмирає. 

// Якщо ватажок стріляється зі звичайним мафіозником, то 65 на 35, що ватажок виживе.

// Перестрілка між групами йде до тих пір, поки не буде переможена повністю команда суперників. Події перестрілки мають бути відображені в консолі.
 
// // Example:

// // North London Clan current team John(boss), Dale, Gena, Bob

// // South London Clan current team Mike(boss), Boris, Ashly, Drake

 

// // John(boss, North London Clan) fight with Boris(casual, South London Clan)

// // John(casual, North London Clan) wins

 

// // North London Clan current team John(boss), Dale, Gena, Bob

// // South London Clan current team Mike(boss), Ashly, Drake

 

// // Bob(casual, North London Clan) fight with Ashly(casual, South London Clan)

// // Ashly(casual, South London Clan) wins

 

// // North London Clan current team John(boss), Dale, Gena

// // South London Clan current team Mike(boss), Ashly, Drake

// //...
 

// Якщо вдалося пограбувати, то клан мафії отримує гроші 50 к баксів. Якщо ні, то сумують )
 

// Реалізувати в Дарт в консолі.

// Я хочу побачити, як ти організуєш ієрархію класів та як ці класи будуть взаємодіяти між собою

// Треба постаратися зробити так, щоб кланів мафії можна було додати у майбутньому скільки завгодно

// В групу можна брати лише одного ватажка та максимальна кількість учасників групи 4 людей (з ватажком)