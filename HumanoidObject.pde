class Humanoid extends Object {
  private float speed;
  private float laserCooldown;
  private float firingSpeed;
  private float health;
  private float maxHealth;
  private boolean isPlr;
  private boolean isSummoned;
  
  public Humanoid() {
    super(320, 520, 0, 0, 25, 25);
    speed = 320;
    firingSpeed = 1.5;
    isPlr = false;
    maxHealth = 50;
    health = maxHealth;
    humans.add(this);
  }
  
  public Humanoid(float x, float y) {
    super(x, y, 0, 0, 25, 25);
    speed = 320;
    firingSpeed = 1.5;
    isPlr = false;
    maxHealth = 50;
    health = maxHealth;
    humans.add(this);
  }
  
  public Humanoid(float x, float y, boolean sum) {
    super(x, y, 0, 0, 25, 25);
    speed = 320;
    firingSpeed = 1.5;
    isPlr = false;
    maxHealth = 50;
    health = maxHealth;
    isSummoned = sum;
    humans.add(this);
  }
  
  public Humanoid(float x, float y, float sp) {
    super(x, y, 0, 0, 25, 25);
    speed = sp;
    firingSpeed = 1.5;
    isPlr = false;
    maxHealth = 50;
    health = maxHealth;
    humans.add(this);
  }
  
  public Humanoid(float x, float y, float sp, float h, float mH, boolean isPlayer) {
    super(x, y, 0, 0, 25, 25);
    speed = sp;
    health = h;
    maxHealth = mH;
    firingSpeed = 1.5;
    isPlr = isPlayer;
    humans.add(this);
  }
  
  public boolean isPlayer() {
    return this.isPlr;
  }
  
  public boolean isSummoned() {
    return this.isSummoned;
  }
  
  public float getHealth() {
    return health;
  }
  
  public float getMaxHealth() {
    return maxHealth;
  }
  
  public float getLaserCooldown() {
    return laserCooldown;
  }
  
  public float getFiringSpeed() {
    return firingSpeed;
  }
  
  public float getSpeed() {
    return speed;
  }
  
  public void shoot(String type) {
    new Laser(getX(), getY(), 0, 640, this.isPlr);
    shoot.play();
  }
  
  public void takeDamage(float val) {
    health -= val;
    if(health < 0) {
      health = 0;
    } else if(health > getMaxHealth()) {
      health = getMaxHealth();
    }
  }
  
  public void setLaserCooldown(float val) {
    laserCooldown = val;
  }
  
  public void setFiringSpeed(float val) {
    firingSpeed = val;
  }
  
  public void setSpeed(float val) {
    speed = val;
  }
  
  public void setHealth(float val) {
    health = val;
  }
  
  public void setMaxHealth(float val) {
    maxHealth = val;
  }
  
  public void update() {
    super.update();
  }
  
  public void show() {
    // show health bar
    noStroke();
    fill(255, 0, 0);
    rect(getX(), getY()+getSizeY()+20, 100, 10);
    fill(0, 255, 0);
    rect(getX(), getY()+getSizeY()+20, health/maxHealth*100, 10);
  }
}
