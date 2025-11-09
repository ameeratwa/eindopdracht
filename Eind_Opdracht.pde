int arrowsLeft = 10; 
float arrowX = 0;
float arrowY = 0;
boolean arrowShow = false;
int score = 0;
boolean gameEnd = false;

float[] enemyX = new float[5];
float[] enemyY = new float[5];
float playerX;

void setup() {
  size(500, 500);
  playerX = 200;
  
  for (int i = 0; i < enemyX.length; i++) {
    enemyX[i] = random(50, 450);
    enemyY[i] = random(-100, 0);
  }
}

void draw() {
  background(0);
  
  // show arrows left
  fill(255);
  text("Arrows: " + arrowsLeft, 400, 30);
  
  if (!gameEnd) {
    // enemies
    for (int i = 0; i < enemyX.length; i++) {
      enemyY[i] = enemyY[i] + 1;
      
      fill(255);
      ellipse(enemyX[i], enemyY[i], 30, 30);
      
      // hit check
      float d = dist(arrowX, arrowY, enemyX[i], enemyY[i]);
      if (d < 15 && arrowShow) {
        enemyX[i] = random(50, 450);
        enemyY[i] = 0;
        arrowShow = false;
        score = score + 10;
        arrowsLeft = arrowsLeft + 1; // get arrow back
      }
      
      // game over if enemy reaches bottom
      if (enemyY[i] > 480) {
        gameEnd = true;
      }
    }

    // arrow
    if(arrowShow) {
      stroke(255);
      arrowY = arrowY - 8;
      line(arrowX, arrowY, arrowX, arrowY - 30);
      stroke(0);
      
      if(arrowY < 0) {
        arrowShow = false;
      }
    }

    if (arrowsLeft <= 0) {
      gameEnd = true;
    }
    
    // player moves with mouse
    playerX = mouseX - 20; 
  } else {
    // game over 
    fill(255);
    textSize(40);
    text("GAME OVER", 120, 200);
    textSize(20);
    text("Score: " + score, 200, 250);
    text("Press ENTER to play again", 150, 300);
  }

  // player
  fill(100, 100, 255);
  rect(playerX, 450, 40, 30);
  
  // score
  fill(255);
  text("Score: " + score, 20, 30);
}

void keyPressed() {  
  // restart game 
  if (gameEnd && keyCode == ENTER) {
    restartGame();
  }
}

void mousePressed(){
  if (!gameEnd && arrowsLeft > 0 && !arrowShow) {
    arrowShow = true;
    arrowY = 450;
    arrowX = playerX + 20;
    arrowsLeft = arrowsLeft - 1;
  }
}

void restartGame() {
  arrowsLeft = 10;
  score = 0;
  gameEnd = false;
  playerX = 200;
  arrowShow = false;
  
  for (int i = 0; i < enemyX.length; i++) {
    enemyX[i] = random(50, 450);
    enemyY[i] = random(-100, 0);
  }
}
