class mainMenu { // The first screen with clickable button
  int x; //Declaration of variables
  int y;
  boolean hover, click = false;
  PImage splash, title; // the images for the background and the title
  
  PImage[] soldierAttacking = new PImage[30]; // Declaring arrays that will later store all the images for the animations
  PImage[] soldierMoving = new PImage[20];
  
  PImage[] zombieMoving = new PImage[16]; 
  PImage[] zombieAttacking = new PImage[18];

  PImage[] upgradedMoving = new PImage[16];
  PImage[] upgradedAttacking = new PImage[18];
  
  mainMenu(int x, int y) { //Main menu constructor
    this.x = x;
    this.y = y;
    splash = loadImage("_Images\\Splash.jpg");
    title = loadImage("_Images\\Title.png");
  }

  void update() {
    render();
    check();
  }

  void render() { 
    image(splash, 0, 0, width, height);
    image(title, 20, 20, 940, 400);

    if (click == false) {
      strokeWeight(5);
      stroke(#767676); //dark grey outer border of the button
      fill(#A7A7A7); //light grey inside of the outer rectangle
      rect(x - 130, y - 25, 260, 50); //this is the rectangle behind the front
      if (hover == false) { // if the mous isnt hovering then it will say dark grey
        fill(#767676);
        stroke(#A7A7A7);
        rect(x - 125, y - 20, 250, 40);
      } else { // once they hover it will turn light gray
        fill(#A7A7A7);
        stroke(#A7A7A7);
        rect(x - 125, y - 20, 250, 40);
      }
      fill(0);
      textSize(46);
      text("Start Game", x - 122, y + 18);
    }
  }

  void check() {
    if (((mouseX >= x - 130) && (mouseX <= x + 130)) && ((mouseY >= y - 25) && (mouseY <= y + 25))) { //Checks around the rectangle button to see if the mouse has hovered over it
      hover = true;
      if (mousePressed == true) { // If they hover and click it will run the game
        click = true; 
      }
    } else {
      hover = false;
    }
  }
  void loadAnimations() {
    rect(50, width/2, 860, 50); // backing of the loading bar
    for (int i = 1; i <= 18; i++) { //Below saves the animation images into the seleted arrays
      zombieAttacking[i-1] = loadImage("_Images\\Zombie\\Attack\\skeleton-attack_" + i + ".png"); // load the images from the directory using i as for which one to load into the array
      upgradedAttacking[i-1] = loadImage("_Images\\Zombie2\\Attack\\skeleton-attack_" + i + ".png");
    }
    for (int i = 0; i < 16; i++) {
      zombieMoving[i] = loadImage("_Images\\Zombie\\Move\\skeleton-move_" + i + ".png");
      upgradedMoving[i] = loadImage("_Images\\Zombie2\\Move\\skeleton-move_" + i + ".png");
    }
    for (int i = 1; i < 31; i++) {
      soldierAttacking[i-1] = loadImage("_Images\\Survivor\\knife\\meleeattack\\survivor-meleeattack_knife_" + i + ".png");
    }
    for (int i = 0; i < 20; i++) {
      soldierMoving[i] = loadImage("_Images\\Survivor\\knife\\move\\survivor-move_knife_" + i + ".png");
    }
  }
}
