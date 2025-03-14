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
  
  List<String> frames = [
    '0____с_____с____',
    '0___с_____с____',
    '0__с_____с____',
    '0_с_____с____',
    '0с_____с____',
  ];
  
  int currentFrame = 0;
  while (!isGameOver) {
  
    print(frames[currentFrame]);
    
    if (frames[currentFrame].contains('0с') && !isJumping) {
      isGameOver = true;
      print(':(____с____');
      print('NO NO GODZILA :(:(:(:(:(:(:(');
      break;
    }
    
    if (frames[currentFrame].startsWith('0с')) {
      obstaclesPassed++;
      if (obstaclesPassed >= obstaclesPassToWin) {
        print('YO YO GODZILA :):):):):):):)');
        break;
      }
    }

    if (isJumping) {
      jumpFramesLeft--;
      if (jumpFramesLeft <= 0) {
        isJumping = false;
        jumpFramesLeft = 0;
      }
      
      currentFrame = (currentFrame + 1) % frames.length;
      
      sleep(Duration(milliseconds: frameTime));
      print('* * * * * * * * * * *');
      continue;
    }

    print('Jump? (+ for yes, - for no)');
    String? input = stdin.readLineSync();
    
    if (input == '+') {
      isJumping = true;
      jumpFramesLeft = jumpFrames;
      
      print('* * * * * * * * * * *');
      print('0 ${frames[currentFrame].substring(2)}');
      sleep(Duration(milliseconds: frameTime));
      print('* * * * * * * * * * *');
      print('0 ${frames[(currentFrame + 1) % frames.length].substring(2)}');
      sleep(Duration(milliseconds: frameTime));
      currentFrame = (currentFrame + 1) % frames.length;
    }
    
    currentFrame = (currentFrame + 1) % frames.length;
    print('* * * * * * * * * * *');
  }
}


// Годзіла для пенсіонерів
// Тобі треба насати гру, де Годзіла буде бігти в слоу мо та стрибати або не стрибати. Ми показуємо анімацію її пересування за кадрами.   Кадри:   0____с_____с____ 
// 0___с_____с____ 
// 0__с_____с____ 
// 0_с_____с____



// 0с_____с____



// :(____с____ (Game Over)   Якщо Годзіла врізається, то гейм овер. Але ми можемо перестрибувати перешкоди.   На кожному кадрі ми запитуємо користувача, робити або не робити стрибок. Якщо робиш, то Годзила летить два кадри вгорі (в цей час не можна робити стрибок кадри повільно перемикаються самі), а потім опиняється на землі.   0____с_____с____  Робимо стрибок   0 __с_____с__ 
// 0 _с_____с__ 
//  0_с_____с____  Знов робимо стрибик 0 с_____с____ 0_с_____с____  Знов робимо стрибик 0 с_____с____ 



// 0 ___с__    0___с____    Як має виглядати з точки зору користувача. GO GO GODZILA  * * * * * * * * * * * 
// 0____с_____с____   Jump? +  
// * * * * * * * * * *
// 0 __с_____с__    
// * * * * * * * * * * 0 _с_____с__    
// * * * * * * * * * * 
// 0_с_____с____    Jump? -



// * * * * * * * * *
// 0с_____с____  
// Jump? -
// * * * * * * * *
// :(_____с____    NO NO GODZILA :(:(:(:(:(:(:(   Якщо перестрибнув дві перешкоди, то перемога. виводиться 
// YO YO GODZILA :):):):):):):)
