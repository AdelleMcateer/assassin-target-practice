/*
Name : Adelle McAteer 
 Student Number: 20091411
 */

public class Enemy   

  //class for the enemy which is a bouncing ball that needs to be shot by the target
{  
  private float enemyX;     //X or starting position of the enemy
  private float enemyY;     //Y or starting position of the enemy 
  private float diameter;  //set the diameter of the enemy
  private float speedX;     //Speed of enemy on the X-axis set so it bounces repeatedly 
  private float speedY;     //Speed of enemy on the Y-axis 

  //getter methods
  public float getEnemyX() {
    return enemyX;
  }

  public float getEnemyY() {
    return enemyY;
  }

  public float getDiameter() {
    return diameter;
  }

  public float getSpeedX() {
    return speedX;
  }

  public float getSpeedY () {
    return speedY;
  }

  //set diameter setter
  public void setDiameter(float diameter) 
  {
    //The enemy diameter must be between 40 and height/10 so it is not 
    //over-sized or too easy to hit with the target
    //Diameter is set to 40 to make it possible to play an easier level game
    if ((diameter>= 40) && (diameter <= height/10)) {  
      this.diameter = diameter;
    } else {
      this.diameter = 30;
    }
  }  

  public void display()      //method to display the enemy 
  {
    fill(255, 0, 0);       //colour of the enemy
    noStroke();            //no outline
    //draw the enemy with the defined co-ordinates
    ellipse(enemyX, enemyY, diameter, diameter);
  }

  //private helper method 
  private void displayEnemy()       //values of the enemy and speed settings
  {
    enemyX = 0;
    enemyY = 0;
    speedX = 1;
    speedY = 1;
  }

  private void drawEnemy() {            //method to draw the enemy 
    if (enemyX < 0 || enemyX > width) speedX = +speedX;  
    else if (enemyY > height) speedY = -speedY;

    else speedY += 1;   //to return the enemy once it reaches the top of the screen

    enemyX += speedX;       //initiating the bouncing effect of the enemy
    enemyY += speedY;
  }

  public Enemy(float diameter)  //enemy constructor       
  {
    setDiameter(diameter);
    displayEnemy();
    drawEnemy();
    resetEnemy();
  }

  //method to reset the enemy if it is shot by the target
  private void resetEnemy()      
  {
    enemyX = 0;
    enemyY = 0;
    speedX = random(3, 5);
    speedY = random(-2, 2);
  }  

  public boolean update()  //paraeters and boolean condition to determine  if a life has been lost
  {
    boolean lifeLost = false;          
    enemyX = enemyX + speedX;
    enemyY = enemyY + speedY;

    //reset the enemy if it leaves the right-hand side of the screen
    if (enemyX > width) {
      resetEnemy();
      lifeLost = true;
    }
    return lifeLost;
  }

  public void run() {      //combine the defined methods into a run method to be called from the main sketch
    enemy.display();
    enemy.drawEnemy();
  }
}
