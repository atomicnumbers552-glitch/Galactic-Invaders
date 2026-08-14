class Boss extends Enemy {
  
  private float lastFrenzy;
  private float frenzyCooldown;
  
  public Boss() {
    super();
    setFiringSpeed(.8);
    setHealth(300);
    setMaxHealth(300);
    setSpeed(100);
  }
  
  public Boss(float x, float y) {
    super(x, y);
    setFiringSpeed(.8);
    setHealth(300);
    setMaxHealth(300);
    setSpeed(100);
  }
  
  public float getLastF() {
    return lastFrenzy;
  }
  
  public float getFCooldown() {
    return frenzyCooldown;
  }
  
  public void setF(float val) {
    lastFrenzy = val;
  }
  
  public void setFCooldown(float val) {
    frenzyCooldown = val;
  }
  
  public void shoot(String type) {
    new Laser(getX(), getY(), 0, 640, isPlayer(), 5);
    shoot.play();
  }
  
  public void update() {
    super.update();
    if(getX() > plr.getX()) {
      setXVel(-getSpeed());
    } else {
      setXVel(getSpeed());
    }
    
    
    if(getLastF() <= 0) {
      setF(12);
      setLaserCooldown(1);
      setFiringSpeed(.8);
      setSpeed(100);
      if(int(random(0, 2)) == 0 && summonedEnemies < 3) {
        summonRandom();
      }
    } else if(getLastF() <= 2) {
      //setXVel(0);
      setFiringSpeed(.03);
      setSpeed(250);
    }
    if(getLastF() > 0) {
      setF(getLastF() - 1*deltaTime);
    }
  }
  
  public void show() {
    noStroke();
    rectMode(CENTER);
    fill(255, 0, 255);
    rect(getX(), getY(), 20, 80);
    rect(getX(), getY()-10, 30, 40);
    rect(getX(), getY()-25, 60, 20);
    rect(getX()+33, getY()-20, 10, 30);
    rect(getX()-33, getY()-20, 10, 30);
    fill(0, 255, 100);
    rect(getX(), getY(), 15, 25);
    // show health bar
    noStroke();
    fill(255, 0, 0);
    rect(getX(), getY()+getSizeY()+7, 100, 10);
    fill(0, 255, 0);
    rect(getX(), getY()+getSizeY()+7, super.getHealth()/super.getMaxHealth()*100, 10);
  }
}
