// ignore_for_file: unused_element

import 'dart:math';

enum Role {
  boss,
  fighter,
  hacker,
  medic,
  financier,
}

class Mafiosnic {
  final String name;
  final Role role;
  int hp;
  int strength;
  int iq;
  int luck;
  int skill;
  int loyalty;

  Mafiosnic(this.name, this.role,
      {this.hp = 100,
      this.strength = 50,
      this.iq = 50,
      this.luck = 50,
      this.skill = 50,
      this.loyalty = 100});

  bool get isAlive => hp > 0;


  static int _generateStat({int min = 30, int max = 100}) {
    return Random().nextInt(max - min + 1) + min;
  }

  bool shouldBetray() {
    return loyalty < 50 && Random().nextInt(100) > loyalty;
  }

  void healBy(int percent) {
    hp = min(100, hp + ((100 * percent) ~/ 100));
  }


  void takeDamage(int amount) {
    hp = max(0, hp - amount);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role.name,
        'strength': strength,
        'iq': iq,
        'luck': luck,
        'skill': skill,
        'loyalty': loyalty,
        'hp': hp,
      };
}
