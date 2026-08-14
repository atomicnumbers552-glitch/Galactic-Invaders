class Object {
  private float x, y, sizeX, sizeY;
  private float xVel, yVel;
  
  private boolean respectBounds;

  public Object() {
    x = 0;
    y = 0;
    sizeX = 0;
    sizeY = 0;
    xVel = 0;
    yVel = 0;
    respectBounds = true;
  }
  
  public Object(boolean rb) {
    x = 0;
    y = 0;
    xVel = 0;
    yVel = 0;
    respectBounds = rb;
  }
  
  public Object(float xP, float yP) {
    x = xP;
    y = yP;
    xVel = 0;
    yVel = 0;
    respectBounds = true;
  }
  
  public Object(float xP, float yP, boolean rb) {
    x = xP;
    y = yP;
    xVel = 0;
    yVel = 0;
    respectBounds = rb;
  }
  
  public Object(float xP, float yP, float xV, float yV) {
    x = xP;
    y = yP;
    xVel = xV;
    yVel = yV;
    respectBounds = true;
  }
  
   public Object(float xP, float yP, float xV, float yV, float sX, float sY) {
    x = xP;
    y = yP;
    sizeX = sX;
    sizeY = sY;
    xVel = xV;
    yVel = yV;
    respectBounds = true;
  }
  
  public Object(float xP, float yP, float xV, float yV, boolean rb) {
    x = xP;
    y = yP;
    xVel = xV;
    yVel = yV;
    respectBounds = rb;
  }
  
  
  public Object(float xP, float yP, float xV, float yV, float sX, float sY, boolean rb) {
    x = xP;
    y = yP;
    sizeX = sX;
    sizeY = sY;
    xVel = xV;
    yVel = yV;
    respectBounds = rb;
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
  
  public float getSizeX() {
    return sizeX;
  }
  
  public float getSizeY() {
    return sizeY;
  }
  
  public float getXVel() {
    return xVel;
  }
  
  public float getYVel() {
    return yVel;
  }
  
  public void setX(float val) {
    x = val;
  }
  
  public void setY(float val) {
    y = val;
  }
  
  public void setXVel(float vel) {
    xVel = vel;
  }
  
  public void setYVel(float vel) {
    yVel = vel;
  }
  
  public void changeXVel(float vel) {
    xVel += vel;
  }
  
  public void changeYVel(float vel) {
    yVel += vel;
  }
  
  public void update() {
    // BASIC MOVEMENT
    x += xVel*deltaTime;
    y += yVel*deltaTime;
    if (respectBounds) {
      if(x-getSizeX() <= 0) {
        x = 0+getSizeX();
      } else if(x+getSizeX() >= width) {
        x = width-getSizeX();
      }
      if(y-getSizeY() <= 0) {
        y = 0+getSizeY();
      } else if(y+getSizeY() >= height) {
        y = height-getSizeY();
      }
    }
  }
  
  public void show() {
    noStroke();
    rectMode(CENTER);
    fill(255, 0, 0);
    rect(getX(), getY(), 50, 50);
  }
}
