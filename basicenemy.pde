class Enemy extends Humanoid {
  
  public Enemy() {
    super(width/2, height/2, 320, 100, 100, true);
  }
  
  public Enemy(float x, float y) {
    super(x, y);
  }
  
  public Enemy(float x, float y, boolean sum) {
    super(x, y, sum);
  }
  
  public void update() {
    super.update();
    if (getY() < height/3*1.5) {
      setYVel(20);
    } else {
      setYVel(0);
    }
    // LASER
    if(getLaserCooldown() <= 0) {
      shoot(null);
      setLaserCooldown(getFiringSpeed());
    }
    if(getLaserCooldown() > 0) {
      setLaserCooldown(getLaserCooldown() - 1*deltaTime);
    }
  }
  
  public void show() {
    noStroke();
    rectMode(CENTER);
    fill(255, 0, 0);
    rect(getX(), getY(), 20, 80);
    rect(getX(), getY()-10, 30, 40);
    rect(getX(), getY()-25, 60, 20);
    rect(getX()+33, getY()-20, 10, 30);
    rect(getX()-33, getY()-20, 10, 30);
    fill(0, 0, 255);
    rect(getX(), getY(), 15, 25);
    // show health bar
    noStroke();
    fill(255, 0, 0);
    rect(getX(), getY()+getSizeY()+20, 100, 10);
    fill(0, 255, 0);
    rect(getX(), getY()+getSizeY()+20, super.getHealth()/super.getMaxHealth()*100, 10);
  }
}
