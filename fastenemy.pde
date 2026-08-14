class FastEnemy extends Enemy {
  
  public FastEnemy() {
    super();
    setFiringSpeed(1.2);
    setHealth(65);
    setMaxHealth(65);
  }
  
  public FastEnemy(float x, float y) {
    super(x, y);
    setFiringSpeed(1.2);
    setHealth(65);
    setMaxHealth(65);
  }
  
  public FastEnemy(float x, float y, boolean sum) {
    super(x, y, sum);
    setFiringSpeed(1.2);
    setHealth(65);
    setMaxHealth(65);
  }
  
  public void shoot(String type) {
    new Laser(getX(), getY(), 0, 640, isPlayer(), 5);
    shoot.play();
  }
  
  public void update() {
    super.update();
    
  }
  
  public void show() {
    noStroke();
    rectMode(CENTER);
    fill(100, 100, 255);
    rect(getX(), getY(), 20, 80);
    rect(getX(), getY()-10, 30, 40);
    rect(getX(), getY()-25, 60, 20);
    rect(getX()+33, getY()-20, 10, 30);
    rect(getX()-33, getY()-20, 10, 30);
    fill(0, 255, 0);
    rect(getX(), getY(), 15, 25);
    // show health bar
    noStroke();
    fill(255, 0, 0);
    rect(getX(), getY()+getSizeY()+20, 100, 10);
    fill(0, 255, 0);
    rect(getX(), getY()+getSizeY()+20, super.getHealth()/super.getMaxHealth()*100, 10);
  }
}
