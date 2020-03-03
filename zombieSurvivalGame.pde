mainMenu M; // declares the classes //<>//
soldier player;
ArrayList<zombie> Enemies; // declares an arrayList for the enemies/zombie class
ArrayList<upgradedZombie> upEnemies; // declares an arrayList for the enemies/zombie class
upgradedZombie upEnemy;
int right, left, up, down, wave = 1, numEnemies = (int)random(1, 3) * wave, deathCount, gate = 265, level; // decleration of global variables
boolean newWave = true, endGame = false, animationLoaded = false;
PImage backImage;

void setup() { // the setup for the main gui and the setup for the classes
  backImage = loadImage("Tiled Build\\test3.png"); // saves the PNG test3 into backImage
  background(255); // sets up the first screen
  size(960, 960);
  smooth();
  ellipseMode(RADIUS); // is used to calculate angles in the zombie and soldier class
  M = new mainMenu(width/2, height/2); // sets the new classes below and sets the variables required
  player = new soldier(350, 350);
  Enemies = new ArrayList<zombie>(); // sets the zombie class as an arrayList allowing for multiple enemies
  Enemies.add(new zombie(random(width/4, width/8), height, (int)random(1, 3), 1)); // adds the first enemy to initialize
  
  upEnemies = new ArrayList<upgradedZombie>(); // sets the zombie class as an arrayList allowing for multiple enemies
  upEnemies.add(new upgradedZombie(random(width/4, width/8), height, (int)random(1, 3), 2)); // adds the first enemy to initialize
}
void draw() {
  if (M.click == true) { // checks if the user has clicked the start game button
    if (endGame == false) { // Checks if the player had lost the game
      if (newWave == true) { // Checks if the next wave needs to be populated
        enemyPopulate();
      } else {
        numEnemies = (int)random(1, 3) * wave; // sets the number of enemies of the next wave
      }
      buildBackground(); // Builds the background that is used possible introduce more levles
      player.update(); // updates the players location and animatios
      player.x += (right - left) * 3; // Calculates which way they need to move and allows for multiple clicks at one time
      player.y += (down - up) * 3;      
      enemyMovement();
      text(deathCount, width - 100, 100); // shows how many enemies the user has killed 
      text("Wave: " + (wave - 1), width/2 - 40, 40); // shows the current wave 
      if (Enemies.size() == 0 && upEnemies.size() == 0) { // checks to see if all the enemies have been killed
        newWave = true; // creates and populates the next wave
      }
      gateHealth(); // checks the gates health
    } else {
      endGameScreen();
    }
  } else {
    // updates the first screen
    if (animationLoaded == false) {
      M.loadAnimations();
      animationLoaded = true;
    }
    else
      M.update();
  }
}



void buildBackground() {
  image(backImage, 0, 0, width, height);
}


void keyPressed() { // Below checks if the user has pressed a key and/or released allowing for more than 1 input to be taken
  if (keyCode == 87) { // use of key code allows for both capitals and lowercase characters to be used
    up = 1;
  }
  if (keyCode == 83) {
    down = 1;
  }
  if (keyCode == 65) {
    left = 1;
  }
  if (keyCode == 68) {
    right = 1;
  }
}

void keyReleased() {
  if (keyCode == 87) {
    up = 0;
  }
  if (keyCode == 83) {
    down = 0;
  }
  if (keyCode == 65) {
    left = 0;
  }
  if (keyCode == 68) {
    right = 0;
  }
}

void enemyPopulate() { //Populates the number of enemies to be played
  numEnemies -= 1; // Takes one from the total amount of enemies to be added
  level = (int)random(1, 3); // picks a number between 1 - 3 but only selects between 1 - 2
  switch(level) { // use of switch case
    case(1): Enemies.add(new zombie(random(0, width), height, (int)random(1, 3), 1));
            break; // add a normal zombie      
    case(2): upEnemies.add(new upgradedZombie(random(0, width), height, (int)random(1, 3), 2));
            break; // add a upgraded zobie if the level is 2
  }
  if (numEnemies <= 0) { // if the number of enemies has been added then start the next wave 
    newWave = false;
    wave += 1;
  }
}

void enemyMovement() {
  // Normal zombie movement
  for (int i = Enemies.size()-1; i >= 0; i--) { // takes the size of the array list - 1 as it is a zero based index and then decrement through each one
    zombie enemy = Enemies.get(i); // this gets the infomation for the enemies array list and declares it to variable enemy
    enemy.update(); //allows for the enemy class to update movement throughout
    if (enemy.collision == true) { // if the user has hit the zombie then it will add one to the death counter and remove the zombie from the screen and array list
      deathCount += 1;
      Enemies.remove(i);
    }
    for (int j = Enemies.size()-1; j >= 0; j--) { // this is a integrated loop to better help with the collisions
      zombie enemy2 = Enemies.get(j); // goes through each other zombie and checks the distance between them
      if (j != i) {
        if ((dist(enemy.x, enemy.y, enemy2.x, enemy2.y) <= 50) || (dist(enemy.x+50, enemy.y+50, enemy2.x+50, enemy2.y+50) <= 50)) { // checks the distance between two points
          enemy.x += 5; // if they are t hen split up the two enemies in different x directions
          enemy2.x -= 5;
        }
      }
    }
  }
  // Upgraded zombie movement
  for (int i = upEnemies.size()-1; i >= 0; i--) { // the same as above but with different variables
    upgradedZombie upEnemy = upEnemies.get(i);
    upEnemy.update();
    if (upEnemy.collision == true) {
      deathCount += 1;
      upEnemies.remove(i);
    }
    for (int j = upEnemies.size()-1; j >= 0; j--) {
      upgradedZombie upEnemy2 = upEnemies.get(j);
      if (j != i) {
        if ((dist(upEnemy.x, upEnemy.y, upEnemy2.x, upEnemy2.y) <= 50) || (dist(upEnemy.x+50, upEnemy.y+50, upEnemy2.x+50, upEnemy2.y+50) <= 50)) {
          upEnemy.x += 5;
          upEnemy2.x -= 5;
        }
      }
    }
  }
}

void gateHealth() { // this is the gates health bar and is controled by the variable gate
  fill(255, 0, 0);
  rect(width/3 + 40, 50, 265, 10);  
  fill(0, 255, 0);
  rect(width/3 + 40, 50, gate, 10);
  if (gate <= 0) {
    endGame = true;
  }
  fill(0);
}

void endGameScreen() { // this is the end screen once the either the gate health is 0 or the players health is 0
  fill(255); // if the player does lose (the gate is destroyed then a death screen is shown and the user needs to leave
  rect(0, 0, width, height);
  fill(0);
  text("YOU DIED", width/2, height/2); // brings text up saying you died
  text("Waves survived: " + wave + ". And killed: " + deathCount, width/2, height/2  - 50); // brings text up saying your score

}
