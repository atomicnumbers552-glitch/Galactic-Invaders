class Player extends Humanoid {

  public Player() {
    super(320, 520, 320, 100, 100, true);
    setSpeed(320);
  }
  
  public void shoot(String type) {
    new Laser(getX(), getY(), 0, -640, isPlayer());
    shoot.play();
  }
  
  public void update() {
    super.update();
    // BASIC MOVEMENT
    super.setXVel(0);
    super.setYVel(0);
    // an math error lets the player move diagonally at 2x the intended speed.
    if(isLeftPressed) {
      super.changeXVel(-getSpeed());
    }
    if(isRightPressed) {
      super.changeXVel(getSpeed());
    }
    if(isUpPressed) {
      super.changeYVel(-getSpeed());
    }
    if(isDownPressed) {
      super.changeYVel(getSpeed());
    }
    // LASER
    if(mousePressed && mouseButton == LEFT && super.getLaserCooldown() <= 0) {
      shoot(null);
      setLaserCooldown(getFiringSpeed());
    }
    if(getLaserCooldown() > 0) {
      setLaserCooldown(getLaserCooldown() - 1*deltaTime);
    }
  }

  public void show() {
    super.show();
    noStroke();
    rectMode(CENTER);
    fill(255, 255, 0);
    rect(getX(), getY(), 20, 80);
    rect(getX(), getY()+10, 30, 40);
    rect(getX(), getY()+25, 60, 20);
    rect(getX()+33, getY()+20, 10, 30);
    rect(getX()-33, getY()+20, 10, 30);
    fill(255, 0, 0);
    rect(getX(), getY(), 15, 25);
  }
}
