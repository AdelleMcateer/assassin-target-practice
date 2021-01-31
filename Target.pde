/*
Name : Adelle McAteer 
 Student Number: 20091411
 */

public class Target  //moving target for shooting the enemy

{
  private int targetX;            //X co-ordinate of the target
  private int targetY;            //Y co-ordinate of the target
  private int targetWidth;        //Target diameter
  private int positionX;          //Setting the position of the target
  private int positionY;          //on the x and y- axis

  //constructor
  public Target(int targetWidth)
  {
    setTargetWidth(targetWidth);

    //the xCoordinate is set here and changes 
    //later in the program as the mouse move on the horizontal plane.
    targetX = height - this.targetWidth;

    //the yCoordinate variable is set here and it stays 
    //this value for a duration of the program as the target is to 
    //be in a fixed position for a shooter style experience

    targetY = height/2;
  }

  //getter methods
  public int getTargetX() {
    return targetX;
  }

  public int getTargetY() {
    return targetY;
  }

  public int getTargetWidth() {
    return targetWidth;
  }

  public int getPositionX() {
    return positionX;
  }

  public int getPositionY() {
    return positionY;
  }

  //setter methods
  public void setTargetX(int targetX) {
    if ((targetX <=0) && (targetX >= height/6)) {
      this.targetX = targetX;
    } else {
      this.targetX = width/2;
    }
  }  
  public void setTargetY(int targetY)
  {
    if ((targetY <= 0) && (targetY >= height/6)) {
      this.targetY = targetY;
    } else {
      this.targetY = height/2;
    }
  }

  public void setTargetWidth(int targetWidth) {
    //The target diameter must be between 20 and height/10
    if ((targetWidth>= 30) && (targetWidth <= height/10)) {
      this.targetWidth = targetWidth;
    } else {
      this.targetWidth = 30;
    }
  }

  //defining the target using the getter methods
  private void displayTarget() {
    targetX = getTargetX();
    targetY = getTargetY();
    targetWidth = getTargetWidth();
    positionX = getPositionX();
    positionY = getPositionY();
  }

  public void drawTarget() //method with parameters to draw three circles within a while loop
  {
    int i = 3;
    while (i > 0)  
    {
      stroke(156);      //setting the target colour to white for the lines/circles
      strokeWeight(3);      //setting the thickness of the lines to 3 pixels
      noFill();             //no colour fill to define the target 
      ellipse(targetX, targetY, targetWidth*i, targetWidth*i);
      i--;
    }

    displayTarget();
  }
  public void updateTarget()      //method to allow the update of the target position

    //display the target in the centre of the screen upon initializing the game
  {
    targetX = CENTER;   
    targetY =  height/2;
    targetWidth = 30;
    positionX = 700;
    positionY = 20;

    //KeyCodes to allow the movement of the target in four different directions
    if (keyPressed) {
      if (keyCode == RIGHT) {
        targetX = positionX/2;
      } else if (keyCode == LEFT) {
        targetX = - positionX/2;
      } else if (keyCode == UP) {
        targetY = positionY;
      } else if (keyCode == DOWN) {
        targetY += positionY*4;
      }
    }
  }
  //allow the repositioning of the target
  public void moveTarget() {        
    targetX += positionX;
    targetY += positionY;
    targetX += targetWidth;
    targetY += targetWidth;
  }

  //calling the methods coded within the object classes to update them within the game
  public void display() {
    target.drawTarget();                
    target.updateTarget();
    target.moveTarget();
  }
}
