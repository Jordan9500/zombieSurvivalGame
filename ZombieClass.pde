class zombie { // The enemy
  float x, y, count, imageCount = 18, angle; // Declaring variables
  boolean move, attack, flip, collision;
  int standingPosition = 2, level, attackPoint, gateX = width/2, gateY, gateDamageCount, playerDamageCount;

  zombie(float x, float y, int attackPoint, int level) { // The Zombie Constructor
    this.x = x;
    this.y = y;
    this.attackPoint = attackPoint;
    this.level = level;
    
  }

  void update() { //Called function that is used to link all the other functions
    move();
    display();
    collisionCheck();
  }

  void move() { // 
    if (attackPoint == 1) { // Checks if the enemy should attack the player or the gate(goal)
      float targetX = player.x; // set the variables to the players coordinates 
      float targetY = player.y;
      if (targetX > x && x < width - 12 || targetX < x && x > 12) { // checks to see if the enemy is between the players x values 
        x += (targetX - x) * 0.01; // if it isnt then it will move the enemy towards the players x location
      }
      if (targetY < y && y > 100 || targetY > y && y < height - 12) { // checks to see if the enemy is between the players y values
        y += (targetY - y) * 0.01; // if it isnt then it will move the enemy towards the players y location
      }
    } else { // attacks gate
      gateY = 100; // Below checks if the user is between the size of the screen and the gate(Goal)
      if (gateX > x && x < width - 12 || gateX < x && x > 12) { // does the same as above but instead with the gateX
        x += (gateX - x) * 0.01;
      }
      if (gateY < y && y > 100 || gateY > y && y < height - 12) {
        y += (gateY - y) * 0.01;
      }
    }
  }

void attack() { 
  if (attack == true) { // checks if is within range below if so
    count = (count + 1) % 18; // proceed with the attack animation
    imageCount -= 1; // moves through the image count til 0 as the amount of frames is 18
    image(M.zombieAttacking[(int)count], -25, -25, 50, 50); // load the image
    if (imageCount == 0) { // if all the frames have been played 
        attack = false; // attack is reset for the next time
        imageCount = 18;
    }
  } else {
    count = (count + 1) % 16; // else do the moving animations 
    image(M.zombieMoving[(int)count], -25, -25, 50, 50);
  }  
}

  void display() {
    gateY = 50;
    pushMatrix(); // pushes the current coordinates system to the stack
    if (attackPoint == 1) {
      angle = atan2((x)-player.x, (y)-player.y); // Below rotates the enemies image to match the players coordinates 
      translate(x, y);
      rotate(-angle-HALF_PI);
      //rect(0, 0, 70, 2); // adds a rectangle and ellipse to check what angle the enenmy is facing. if needed for testing
      //ellipse(0, 0, 10, 10);
    } else {
      angle = atan2((x)-gateX, (y)-gateY); // Below rotates the enemies image to match the gates coordinates 
      translate(x, y);
      rotate(-angle-HALF_PI);
      //rect(0, 0, 70, 2);   // adds a rectangle and ellipse to check what angle the enenmy is facing 
      //ellipse(0, 0, 10, 10);
    }
    attack();
    if (collision == true) { // checks to see if the user has been hit by the player if so
      x = random(0, width); // resets the enemy
      y = height; 
      collision = false;
    }
    popMatrix(); // restores the prior coordinate system
  }

  void collisionCheck() {
    if (dist(x, y, player.x, player.y) <= 50) // Checks a block around the player if the enemy is within the bloakc
      if (player.click == true && player.imageCount >= 20) { // and the player has clicked the screen to attack
        if ((angle != player.angle)) {
          collision = true; // it will run the collision
        }
      } else {
        attack = true; // otherwise the enemy will attack
        playerDamageCount += 1;
        if (playerDamageCount % 10 == 0) { // if the player has been hit by the attack ten times then take 1 health away
          player.playerHealth -= 1;  
        }
      }
    if (dist(x, y, gateX, gateY) <= 60) { // Checks the distance the enemy is from the gate if it is closer than 60 pixels then
      attack = true; // Start the attack sequence 
      gateDamageCount += 1; // Add 1 to the damage count
      if (gateDamageCount % 10 == 0) { // When the damage count is been done every 10th time
        gate -= 1; // It takes 1 away from the gates health
      }
    }
  }
}
