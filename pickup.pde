class Pickup extends Object {
  private boolean hit;
  private float healAmount = 25;
  
  public Pickup() {
    super(width/2, height/2, 35, 35, false);
    pickups.add(this);
  }
  
  public Pickup(float xP, float yP) {
    super(xP, yP, 0, 100, false);
    pickups.add(this);
  }
  
  public boolean hitHuman() {
    return hit;
  }
  
  public void update() {
    super.update();
    for(int i = 0; i < humans.size(); i++) {
      Humanoid h = humans.get(i);
      if(getX() > h.getX()-h.getSizeX() && getX() < h.getX()+h.getSizeX() && getY() > h.getY()-h.getSizeY() && getY() < h.getY()+h.getSizeY()) { // && getX() < h.getX()+h.getSizeX() && getY() > h.getY()-h.getSizeY() && getY() < h.getY()+h.getSizeY()
        if(h.isPlayer()) {
          h.takeDamage(-healAmount);
          hit = true;
          break;
        }
      }
    }
  }
  
  public void show() {
    noStroke();
    fill(0, 255, 0);
    circle(getX(), getY(), 40);
    fill(255, 255, 255);
    rect(getX(), getY(), 30, 10);
    rect(getX(), getY(), 10, 30);
  }
}
