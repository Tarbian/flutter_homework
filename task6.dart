import 'dart:io';

const obstaclesPassToWin = 2;
const jumpFrames = 2;
const frameTime = 800;
const obstaclePositions = [4, 10];
const scneneLength = 15;
const obstacleChar = 'c';
const groundChar = '_';
const godzillaChar = '0';

void main() {
  print('GO GO GODZILA');
  print('* * * * * * * * * * *');

  bool isGameOver = false;
  bool isJumping = false;
  int jumpFramesLeft = 0;
  int obstaclesPassed = 0;
  int gamePosition = 0;

  while (!isGameOver) {
    renderScene(gamePosition, isJumping);

    if (checkCollision(gamePosition, isJumping)) {
      isGameOver = true;
      print(':(____с____');
      print('NO NO GODZILA :(:(:(:(:(:(:(');
      break;
    }

    if (checkObstaclesPassed(gamePosition)) {
      obstaclesPassed++;
      if (obstaclesPassed >= obstaclesPassToWin) {
        print('YO YO GODZILA :):):):):):):)');
        isGameOver = true;
        break;
      }
    }

    if (isJumping) {
      jumpFramesLeft--;
      if (jumpFramesLeft <= 0) {
        isJumping = false;
        jumpFramesLeft = 0;
      }

      gamePosition++;

      sleep(Duration(milliseconds: frameTime));
      print('* * * * * * * * * * *');
      continue;
    }

    print('Jump? (+ for yes, - for no)');
    String? input = stdin.readLineSync();

    if (input == '+') {
      isJumping = true;
      jumpFramesLeft = jumpFrames;
    }

    gamePosition++;
    print('* * * * * * * * * * *');
  }
}

void renderScene(int gamePosition, bool isJumping) {
  String playerChar = isJumping ? '${godzillaChar}\n' : godzillaChar;
  String scene = playerChar;

  for (int i = 0; i < scneneLength; i++) {
    bool hasObstacle = obstaclePositions
        .any((pos) => (pos - gamePosition) % scneneLength == i);
    scene += hasObstacle ? obstacleChar : groundChar;
  }

  print(scene);
}

bool checkCollision(int gamePosition, bool isJumping) {
  if (isJumping) {
    return false;
  }

  return checkObstaclesPassed(gamePosition);
}

bool checkObstaclesPassed(int gamePosition) {
  return obstaclePositions
      .any((pos) => (pos - gamePosition) % scneneLength == 0);
}
