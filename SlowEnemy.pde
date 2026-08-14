class SlowEnemy extends Enemy {
  
  public SlowEnemy() {
    super();
    setFiringSpeed(3);
    setHealth(120);
    setMaxHealth(120);
  }
  
  public SlowEnemy(float x, float y) {
    super(x, y);
    setFiringSpeed(3);
    setHealth(150);
    setMaxHealth(150);
  }
  
  public SlowEnemy(float x, float y, boolean sum) {
    super(x, y, sum);
    setFiringSpeed(3);
    setHealth(150);
    setMaxHealth(150);
  }
  
  public void shoot(String type) {
    new Laser(getX(), getY(), 0, 640, isPlayer(), 30);
    shoot.play();
  }
  
  public void update() {
    super.update();
  }
  
  public void show() {
    noStroke();
    rectMode(CENTER);
    fill(127, 0, 127);
    rect(getX(), getY(), 20, 80);
    rect(getX(), getY()-10, 30, 40);
    rect(getX(), getY()-25, 60, 20);
    rect(getX()+33, getY()-20, 10, 30);
    rect(getX()-33, getY()-20, 10, 30);
    fill(127, 0, 0);
    rect(getX(), getY(), 15, 25);
    // show health bar
    noStroke();
    fill(255, 0, 0);
    rect(getX(), getY()+getSizeY()+15, 100, 10);
    fill(0, 255, 0);
    rect(getX(), getY()+getSizeY()+15, super.getHealth()/super.getMaxHealth()*100, 10);
  }
}
