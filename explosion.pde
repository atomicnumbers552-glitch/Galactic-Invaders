class Explosion extends Particle {
  
  public float drag;
  
  public Explosion(float x, float y, float lt) {
    super(x, y, random(-340, 340), random(-340, 340), lt);
    drag = random(.01, .03);
  }
  
  public void update() {
    super.update();
    setXVel(lerp(getXVel(), 0, drag));
    setYVel(lerp(getYVel(), 0, drag));
  }
  
  public void show() {
    noStroke();
    fill(255, 255, 0, 255*(1-(super.getTime()/super.getLifetime())));
    circle(getX(), getY(), 20);
  }
}
