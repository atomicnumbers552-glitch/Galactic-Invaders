class Particle extends Object {
  
  private float timeStamp;
  private float lifetime;
  
  public Particle(float xP, float yP, float xV, float yV, float lt) {
    super(xP, yP, xV, yV, true);
    timeStamp = worldTimer;
    lifetime = lt;
  }
  
  public float getTime() {
    return worldTimer - timeStamp;
  }
  
  public float getLifetime() {
    return lifetime;
  }
  
  public boolean isOverdue() {
    return worldTimer - timeStamp > lifetime;
  }
}
