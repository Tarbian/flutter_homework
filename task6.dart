import 'dart:io';

const obstaclesPassToWin = 2;
const jumpFrames = 2;
const frameTime = 800;

void main() {
  print('GO GO GODZILA');
  print('* * * * * * * * * * *');

  bool isGameOver = false;
  bool isJumping = false;
  int jumpFramesLeft = 0;
  int obstaclesPassed = 0;
  
  List<int> obstaclePositions = [4, 10];
  int gamePosition = 0;
  
  while (!isGameOver) {
    if (isJumping) {
      String scene = '0\n';
      
      for (int i = 0; i < 15; i++) {
        bool hasObstacle = false;
        for (int pos in obstaclePositions) {
          if ((pos - gamePosition) % 15 == i) {
            hasObstacle = true;
            break;
          }
        }
        scene += hasObstacle ? 'с' : '_';
      }
      print(scene);
    } else {
      String scene = '0';
      
      for (int i = 0; i < 15; i++) {
        bool hasObstacle = false;
        for (int pos in obstaclePositions) {
          if ((pos - gamePosition) % 15 == i) {
            hasObstacle = true;
            break;
          }
        }
        scene += hasObstacle ? 'с' : '_';
      }
      print(scene);
    }
    
    bool collisionDetected = false;
    for (int pos in obstaclePositions) {
      if ((pos - gamePosition) % 15 == 0 && !isJumping) {
        collisionDetected = true;
        break;
      }
    }
    
    if (collisionDetected) {
      isGameOver = true;
      print(':(____с____');
      print('NO NO GODZILA :(:(:(:(:(:(:(');
      break;
    }
    
    for (int pos in obstaclePositions) {
      if ((pos - gamePosition) % 15 == 0) {
        obstaclesPassed++;
        if (obstaclesPassed >= obstaclesPassToWin) {
          print('YO YO GODZILA :):):):):):):)');
          isGameOver = true;
          break;
        }
      }
    }
    
    if (isGameOver) break;
    
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
