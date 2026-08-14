class Button extends Object {
  
  private String text;
  private boolean pressed;
  private boolean active;
  
  public Button(float xP, float yP, float sX, float sY, String tx) {
    super(xP, yP, 0, 0, sX, sY, false);
    text = tx;
    buttons.add(this);
  }
  
  public String getText() {
    return text;
  }
  
  public boolean isPressed() {
    return pressed;
  }
  
  public boolean isActive() {
    return active;
  }
  
  public void setText(String tx) {
    text = tx;
  }
  
  public void onClicked() {
    pressed = true;
  }
  
  public void reset() {
    pressed = false;
  }
  
  public void toggle(boolean t) {
    active = t;
  }
  
  public void show() {
    rectMode(CENTER);
    strokeWeight(5);
    fill(127, 255, 0);
    rect(getX(), getY(), getSizeX(), getSizeY());
    fill(0, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(30);
    text(text, getX(), getY());
  }
}
