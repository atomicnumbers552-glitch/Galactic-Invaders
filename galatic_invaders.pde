import processing.sound.*;

SoundFile shoot;
SoundFile hitS;
SoundFile takedown;
SoundFile music;
SoundFile bossMusic;

Player plr;

// 0 - title screen
// 1 - ingame
// 2 - shop
int stage = 0;
int wave = 0;
int enemiesKilled = 0;
int enemyIndex = 0;
int summonedEnemies = 0;

float PLR_SPEED = 320;
float spawnCooldown = 0;
float starCooldown = 0;
float starSpeed = 90;
float DEBOUNCE_TIME = 5;
float SPAWN_DEBOUNCE_TIME = 10;
float STAR_DEBOUNCE_TIME = .2;
float deltaTime = 0;
float worldTimer = 0;

ArrayList<Star> numOfStars = new ArrayList<Star>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Humanoid> humans = new ArrayList<Humanoid>();
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Button> buttons = new ArrayList<Button>();
ArrayList<Pickup> pickups = new ArrayList<Pickup>();

ArrayList<ArrayList<String>> waves = new ArrayList<ArrayList<String>>();
ArrayList<String> wave1 = new ArrayList<String>() {
    {
        add("Enemy");
        add("Enemy");
        add("Enemy");
        add("Enemy");
        add("Enemy");
    }
};
ArrayList<String> wave2 = new ArrayList<String>() {
    {
        add("Enemy");
        add("Fast");
        add("Enemy");
        add("Fast");
        add("Enemy");
    }
};
ArrayList<String> wave3 = new ArrayList<String>() {
    {
        add("Fast");
        add("Slow");
        add("Fast");
        add("Slow");
        add("Fast");
    }
};
ArrayList<String> wave4 = new ArrayList<String>() {
    {
        add("Boss");
    }
};


// INPUT
boolean isLeftPressed = false;
boolean isRightPressed = false;
boolean isUpPressed = false;
boolean isDownPressed = false;

Button play;
Button dmgUpg;
Button healUpg;
Button speedUpg;

void setup() {
  size(640, 640);
  background(0);
  play = new Button(width/2, height/2+100, 200, 100, "PLAY");
  dmgUpg = new Button(width/8, height/2+100, 125, 100, "MORE DMG");
  healUpg = new Button(width/8*4, height/2+100, 125, 100, "SHIP UPG");
  speedUpg = new Button(width/8*7, height/2+100, 125, 100, "JET UPG");
  play.toggle(true);
  waves.add(wave1);
  waves.add(wave2);
  waves.add(wave3);
  waves.add(wave4);
  shoot = new SoundFile(this, "data/shoot.mp3");
  hitS = new SoundFile(this, "data/hit.mp3");
  takedown = new SoundFile(this, "data/takedown.mp3");
  music = new SoundFile(this, "data/bgdmusic.mp3");
  music.loop();
}

void draw() {
  deltaTime = 1/frameRate;
  worldTimer += deltaTime;
  
  if(stage == 0) {
    titleScreen();
  } else if (stage == 1 || stage == 2) {
    if(starCooldown > 0) {
      starCooldown -= 1*deltaTime;
    }
    if(starCooldown <= 0) {
      numOfStars.add(new Star());
      starCooldown = STAR_DEBOUNCE_TIME;
    }
    //println(laserCooldown);
   // println(frameRate);
    background(0);
    for(int i = numOfStars.size() - 1; i >= 0; i--) {
      Star s = numOfStars.get(i);
      s.update();
      s.show();
      if(s.getY() > height+2) {
        numOfStars.remove(i);
      }
    }
    //plr.update();
    //plr.show();
    if(stage == 1) {
      if(spawnCooldown <= 0) {
        if(enemyIndex < waves.get(wave).size()) {
          if(waves.get(wave).get(enemyIndex) == "Enemy") {
            new Enemy(random(0, width), 0);
          } else if(waves.get(wave).get(enemyIndex) == "Fast") {
            new FastEnemy(random(0, width), 0);
          } else if(waves.get(wave).get(enemyIndex) == "Slow") {
            new SlowEnemy(random(0, width), 0);
          } else if(waves.get(wave).get(enemyIndex) == "Boss") {
            new Boss(width/2, 0);
            starSpeed = 400;
          }
        }
        spawnCooldown = SPAWN_DEBOUNCE_TIME;
        enemyIndex++;
      }
    }
    if(spawnCooldown > 0) {
      spawnCooldown -= 1*deltaTime;
    }
    if(stage == 1) {
      if(enemiesKilled >= waves.get(wave).size()) {
        wave++;
        enemyIndex = 0;
        enemiesKilled = 0;
        stage = 2;
        dmgUpg.toggle(true);
        healUpg.toggle(true);
        speedUpg.toggle(true);
      }
    }
    if(wave >= waves.size()) {
       stage = 3;
       play.toggle(true);
    }
    for(int i = 0; i < humans.size(); i++) {
      Humanoid h = humans.get(i);
      h.update();
      h.show();
      if(h.getHealth() <= 0) {
        createExplosion(h.getX(), h.getY());
        if(!h.isPlayer()) {
          if(!h.isSummoned) {
            enemiesKilled++;
          } else {
            summonedEnemies--;
          }
          //if(random(1, 10) == 10) {
            spawnPickup(h.getX(), h.getY());
         // }
        }
        humans.remove(i);
      }
    }
    for(int i = pickups.size() - 1; i >= 0; i--) {
      Pickup p = pickups.get(i);
      p.update();
      p.show();
      if(p.getY() < 0 || p.getY() > height+5 || p.hitHuman()) {
        pickups.remove(i);
      }
    }
    for(int i = lasers.size() - 1; i >= 0; i--) {
      Laser l = lasers.get(i);
      l.update();
      l.show();
      if(l.getY() < 0 || l.getY() > height+5 || l.hitHuman()) {
        lasers.remove(i);
      }
    }
    textAlign(CENTER);
    textSize(35);
    fill(0, 255, 0);
    text("WAVE " + (wave+1), width/2, 45);
    if(stage == 2) {
      shop();
    }
    if(plr.getHealth() <= 0) {
      stage = 0;
      play.toggle(true);
    }
  } else if (stage == 3) {
    win();
  }
  textAlign(LEFT);
  textSize(15);
  fill(0, 255, 0);
  text(floor(frameRate+.5), 0, 15);
  for(int i = particles.size() - 1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.update();
      p.show();
      if(p.getX() <= 0) {
        particles.remove(i);
        continue;
      } else if(p.getX() >= width) {
        particles.remove(i);
        continue;
      }
      if(p.getY() <= 0) {
        particles.remove(i);
        continue;
      } else if(p.getY() >= height) {
        particles.remove(i);
        continue;
      }
      if(p.isOverdue()) {
        particles.remove(i);
        continue;
      }
    }
};

// SCREENS
void titleScreen() {
  background(0);
  fill(255, 127, 0);
  textAlign(CENTER);
  textSize(60);
  text("Galatic Intruders",width/2,120);
  textAlign(CENTER);
  textSize(30);
  text("Inspired by Space Invaders",width/2,145);
  textAlign(CENTER);
  textSize(20);
  text("Made by Andrew",width/2,170);
  textAlign(CENTER);
  textSize(18);
  text("Powered by Processing",width/2,190);
  textSize(18);
  text("Music by ParagonX9",width/2,210);
  play.show();
  if(play.isPressed()) {
    play.toggle(false);
    numOfStars = new ArrayList<Star>();
    // add stars to the background when starting so it isn't black
    for(int i = 0; i < 8; i++) {
      numOfStars.add(new Star(random(0, width), random(0, height)));
    }
    lasers = new ArrayList<Laser>();
    humans = new ArrayList<Humanoid>();
    particles = new ArrayList<Particle>();
    pickups = new ArrayList<Pickup>();
    plr = new Player();
    play.reset();
    starSpeed = 90;
    // wave = 3;
    enemyIndex = 0;
    summonedEnemies = 0;
    stage = 1;
  }
}

void win() {
  background(0);
  fill(255, 127, 0);
  textAlign(CENTER);
  textSize(80);
  text("YOU WON!",width/2,height/2);
  play.show();
  if(play.isPressed()) {
    play.toggle(false);
    numOfStars = new ArrayList<Star>();
    // add stars to the background when starting so it isn't black
    for(int i = 0; i < 8; i++) {
      numOfStars.add(new Star(random(0, width), random(0, height)));
    }
    lasers = new ArrayList<Laser>();
    humans = new ArrayList<Humanoid>();
    particles = new ArrayList<Particle>();
    pickups = new ArrayList<Pickup>();
    plr = new Player();
    play.reset();
    starSpeed = 90;
    wave = 0;
    enemyIndex = 0;
    summonedEnemies = 0;
    stage = 1;
  }
}

void shop() {
  dmgUpg.show();
  healUpg.show();
  speedUpg.show();
  if(dmgUpg.isPressed()) {
    dmgUpg.reset();
    dmgUpg.toggle(false);
    healUpg.toggle(false);
    speedUpg.toggle(false);
    plr.setFiringSpeed(plr.getFiringSpeed() - .2);
    stage = 1;
  }
  if(healUpg.isPressed()) {
    healUpg.reset();
    dmgUpg.toggle(false);
    healUpg.toggle(false);
    speedUpg.toggle(false);
    plr.setMaxHealth(plr.getMaxHealth() + 25);
    stage = 1;
  }
  if(speedUpg.isPressed()) {
    speedUpg.reset();
    dmgUpg.toggle(false);
    healUpg.toggle(false);
    speedUpg.toggle(false);
    plr.setSpeed(plr.getSpeed() + 25);
    stage = 1;
  }
}


// PARTICLES
void createExplosion(float x, float y) {
  for(int j = 0; j < random(25, 65); j++) {
    particles.add(new Explosion(x, y, random(.95, 1.75)));
  }
  takedown.play();
}

void spawnPickup(float x, float y) {
  new Pickup(x, y);
}

void summonRandom() {
  summonedEnemies++;
  int ran = int(random(1, 3));
  if(ran == 1) {
    new Enemy(random(0, width), 0, true);
  } else if(ran == 2) {
    new FastEnemy(random(0, width), 0, true);
  }
}

// INPUT DETECTION
void keyPressed() {
  // BASIC MOVEMENT
  if(keyCode == LEFT || key == 'a') {
    isLeftPressed = true;
   }
   if(keyCode == RIGHT || key == 'd') {
     isRightPressed = true;
   }
   if(keyCode == UP || key == 'w') {
     //isUpPressed = true;
   }
   if(keyCode == DOWN || key == 's') {
     //isDownPressed = true;
   }
}

// INPUT DETECTION
void keyReleased() {
  // BASIC MOVEMENT
  if(keyCode == LEFT || key == 'a') {
    isLeftPressed = false;
   }
   if(keyCode == RIGHT || key == 'd') {
     isRightPressed = false;
   }
   if(keyCode == UP || key == 'w') {
     //isUpPressed = false;
   }
   if(keyCode == DOWN || key == 's') {
     //isDownPressed = false;
   }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    for(Button b : buttons) {
      if(mouseX > b.getX()-b.getSizeX()/2 && mouseX < b.getX()+b.getSizeX()/2 && mouseY > b.getY()-b.getSizeY()/2 && mouseY < b.getY()+b.getSizeY()/2 && b.isActive()) {
        b.onClicked();
      }
    }
  }
}

//if(keyPressed) {
//    if(keyCode == LEFT) {
//      xVel -= PLR_SPEED;
//    }
//    if(keyCode == RIGHT) {
//      xVel += PLR_SPEED;
//    }
 //   if(keyCode == UP) {
 //     yVel -= PLR_SPEED;
//    }
 //   if(keyCode == DOWN) {
//      yVel += PLR_SPEED;
//    }
