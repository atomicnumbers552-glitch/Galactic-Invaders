class Star extends Object {
  private float radius;
  
  public Star() {
    super(random(0, width), 0, 0, starSpeed, false);
    radius = 2;
  }
  
  public Star(float x, float y) {
    super(x, y, 0, starSpeed, false);
    radius = 2;
  }
  
  public void update() {
    super.update();
    setXVel(random(-.2, .2)*60);
    setYVel(starSpeed);
  }
  
  public void show() {
    noStroke();
    fill(255);
    circle(getX(), getY(), radius);
  }
}
