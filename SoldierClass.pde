class soldier { // The user
  float x, y, count, imageCount = 30, angle; //declaring the variables
  boolean move, click, flip;
  int standingPosition = 2, playerHealth = 200;
  float endX = 0, endY = 0;
  soldier(int x, int y) {  // The User Constructor
    this.x = x;
    this.y = y;
  }

  void update() { //Called function that is used to link all the other functions
    check();
    display();
    hudBuild();
  }

  void check() {
    if (mousePressed) { // checks if the mouse has been pressed if so the set click and count
      if (click == false) {
        click = true;  
        count = 0;
      }
    }
  }

  void display() {
    pushMatrix(); // pushes the current coordinates system to the stack
    angle = atan2((x)-mouseX, (y)-mouseY); // Below rotates the players image to match the mouse coordinates 
    translate(x, y);
    rotate(-angle-HALF_PI);
    //rect(endX, endY, 70, 2);  // adds a rectangle and ellipse to check what angle the enenmy is facing. if needed for testing
    //ellipse(0, 0, 10, 10);
    if (click == true) { // if the player has clicked the mouse 
      count = (count + 1) % 30; // run the attack sequence that has 30 frames
      imageCount -= 1; // go down the image count from 30 to 0
      image(M.soldierAttacking[(int)count], -25, -25, 50, 70); // load each frame
      if (imageCount == 0) { // once the attack animation has been completed once then
        click = false; // reset the click and image counter
        imageCount = 30;
      }
    } else {
      count = (count + 1) % 19; // else prceed with the moving animations
      image(M.soldierMoving[(int)count], -25, -25, 50, 50);
    }
    popMatrix(); // restores the prior coordinate system
  }
  void hudBuild() { // adds the players health to the top right of the screen
    textSize(30); // set text size to 30
    text("Player Health", 40, 40);
    fill(255, 0, 0);
    rect(40, 50, 200, 10);  
    fill(0, 255, 0);
    rect(40, 50, playerHealth, 10);
    if (playerHealth <= 0) { // if the players health = 0 then end the game 
      endGame = true;
    }
    fill(0);
  }
}
