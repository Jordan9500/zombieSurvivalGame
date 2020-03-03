class upgradedZombie extends zombie { // the uprgraded zombie subclass of the zombie super class
  //Inheritance
  float count;
  upgradedZombie(float x, float y, int attackPoint, int level) { // The Ugraded Zombie Constructor
    super(x, y, attackPoint, level); // used to match the zombies class
  }
  
  void update() {
    move(); // calls the move function 
    display2();
    collisionCheck();    
  }
  
  void display2() {
    gateY = 50;
    pushMatrix();
    if (attackPoint == 1) {
      angle = atan2((x)-player.x, (y)-player.y); // Below rotates the enemies image to match the players coordinates 
      translate(x, y);
      rotate(-angle-HALF_PI);
      rect(0, 0, 70, 2); // adds a rectangle and ellipse to check what angle the enenmy is facing 
      ellipse(0, 0, 10, 10);
    } else {
      angle = atan2((x)-gateX, (y)-gateY); // Below rotates the enemies image to match the gates coordinates 
      translate(x, y);
      rotate(-angle-HALF_PI);
      rect(0, 0, 70, 2);   // adds a rectangle and ellipse to check what angle the enenmy is facing 
      ellipse(0, 0, 10, 10);
    }
    attack2();
    if (collision == true) {
      x = random(0, width); // resets the enemy
      y = height; 
      collision = false;
    }
    popMatrix();
  }
  void attack2() {
    if (attack == true) {  // checks if is within range below if so
      count = (count + 1) % 18; // proceed with the attack animation
      imageCount -= 1;  // moves through the image count til 0 as the amount of frames is 18
      image(M.upgradedAttacking[(int)count], -25, -25, 50, 50); // load the image
      if (imageCount == 0) { // if all the frames have been played 
          attack = false; // attack is reset for the next time
          imageCount = 18;
      }
    } else {
      count = (count + 1) % 16; // else do the moving animations 
      image(M.upgradedMoving[(int)count], -25, -25, 50, 50);
    }  
  }
}
