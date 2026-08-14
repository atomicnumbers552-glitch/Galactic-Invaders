class Laser extends Object {
  private float damage;
  //private float speed = 640;
  private boolean fromPlayer;
  private boolean hit;
  
  public Laser() {
    super(width/2, height/2, 0, -640, false);
    damage = 10;
    lasers.add(this);
  }
  
  public Laser(float xP, float yP, boolean ofPlr) {
    super(xP, yP, 0, -640, false);
    fromPlayer = ofPlr;
    damage = 10;
    lasers.add(this);
  }
  
  public Laser(float xP, float yP, boolean ofPlr, float dmg) {
    super(xP, yP, 0, -640, false);
    fromPlayer = ofPlr;
    damage = dmg;
    lasers.add(this);
  }
  
  public Laser(float xP, float yP, float xV, float yV, boolean ofPlr) {
    super(xP, yP, xV, yV, false);
    fromPlayer = ofPlr;
    damage = 10;
    lasers.add(this);
  }
  
  public Laser(float xP, float yP, float xV, float yV, boolean ofPlr, float dmg) {
    super(xP, yP, xV, yV, false);
    fromPlayer = ofPlr;
    damage = dmg;
    lasers.add(this);
  }
  
  public boolean hitHuman() {
    return hit;
  }
  
  public void update() {
    super.update();
    for(int i = 0; i < humans.size(); i++) {
      Humanoid h = humans.get(i);
      if(getX() > h.getX()-h.getSizeX() && getX() < h.getX()+h.getSizeX() && getY() > h.getY()-h.getSizeY() && getY() < h.getY()+h.getSizeY()) { // && getX() < h.getX()+h.getSizeX() && getY() > h.getY()-h.getSizeY() && getY() < h.getY()+h.getSizeY()
        if(fromPlayer != h.isPlayer()) {
          h.takeDamage(damage);
          hit = true;
          hitS.play();
          break;
        }
      }
    }
  }
  
  public void show() {
    noStroke();
    fill(255, 0, 0);
    rect(getX(), getY(), 4, 14);
  }
}
