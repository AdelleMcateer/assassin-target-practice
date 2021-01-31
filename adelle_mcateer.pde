/*
Name : Adelle McAteer 
 Student Number: 20091411
 */

import javax.swing.*;

//Objects required in the program
Target target;
Enemy enemy;
Assassin assassin;

//Array data to generate multiple decoy enemies
Enemy[] enemies;

//Current game data 
int livesLost = 0;             //keeps track of the lives lost in current game
int shot = 0;                  //number of enemies shot in the current game
int maxLivesPerGame = 5;       /*maximum number of lives that can be lost before 
 the practice ends */

//Practice session data
int maxNumberOfGames = 5;      //maximum number of games/practice sessions that can be played
int numberOfGamesPlayed = 0;   //number of games played, so far, in target practice

void setup()
{
  size(1600, 400);             //set the size of the display window for the game
  surface.setLocation(0, 0);   /* set location to so the game window opens at the 
   top right hand-corner */

  //setting the size of the target and enemy with hard-coded sizes 
  target = new Target(20);     
  enemy = new Enemy(30.0);

  //JOptionPane to show dialog box and take a value from the user
  maxNumberOfGames = Integer.parseInt(JOptionPane.showInputDialog
    ("Welcome to Assassin Target Practice\n\n"
    + "Please enter the number of practice sessions you would like: \n\n", "5"));

  JOptionPane.showMessageDialog
    (frame, 
    "Try to shoot as many enemies as possible.\n\n"
    + "Press/Hold the arrow keys to position the target. \n\n"
    + "When the screen flashes red the enemy is in range. \n\n" 
    + "Press the mouse to shoot. \n\n"
    + "Be careful as not all enemies can be shot. ");

  assassin = new Assassin(JOptionPane.showInputDialog
    ("Enter the Assassin name:"), maxNumberOfGames);

  //Array setting the number of decoy enemies to five
  enemies = new Enemy[5];

  // For loop to count the length of the array and draw the enemy
  for (int i = 0; i< enemies.length; i++) {
    enemies[i]= new Enemy(30.0);
  }
}

void draw() 
{
  background(0);           //Set the background to black
  noCursor();              //to remove the mouse pointer 

  //calling the public methods within the object classes 
  target.display();                //display the target                   
  enemy.run();                     //display the enemy 
  assassin.toString();             //toString method keeping track of enemies shot 

  //for loop to run the array 
  for (int i = 0; i < enemies.length; i++) {
    enemies[i].display();
    enemies[i].update();
    enemies[i].drawEnemy();
  }

  //Update the enemy position. If true is returned, the enemy has left the display 
  //window i.e. a life is lost
  if (enemy.update() == true) {
    livesLost++;
    println("Lives lost: " + livesLost);
  }

  //If the player still has a life left in the current practice,
  //draw the enemy so that it returns to the screen
  if (livesLost < maxLivesPerGame) {
    enemy.display(); 
    //Set variable to true if enemy and target are overlapping, false if not
    boolean collision = hitTarget(target, enemy);
    if (collision == true) { 
      background(255, 0, 0);         //Turn the background red to show the enemy is within range
      if (mousePressed) {
        //the enemy is reset and regenerates from the left of the screen
        enemy.resetEnemy(); 
        //increase score in the current game by 1, if  the player shoots the enemy 
        shot++;              
        println("Enemies shot: " + shot);
      }
    }
  }

  //If the player has no lives left so the game ends
  else {
    assassin.addShot(shot); 
    numberOfGamesPlayed++;
    //If the player has more games left in the tournament,
    //display their score and ask them if they want to continue with the tournament.
    if (numberOfGamesPlayed < maxNumberOfGames) {
      int reply = JOptionPane.showConfirmDialog(null, 
        "Target Practice is Over! You shot " + shot + " enemies.\n Would you like to practice again?", 
        "Start next practice session?", 
        JOptionPane.YES_NO_OPTION);
      if (reply == JOptionPane.YES_OPTION) {
        //player chooses to play the next game in their practice session.
        resetGame();
      } else {
        //player chooses to leave the target practice early.
        practiceOver();
      }
    } else {
      //the player has no more games left in target practice
      practiceOver();
    }
  }
}

//method prepares for the next game by resetting the variable that stores the current
//game information
void resetGame()
{
  println("Game Over!");
  println("Starting a new game...");
  livesLost = 0;        //resets the lives lost in the current game to zero
  shot = 0;           //resets the score of the current game to zero
}

void practiceOver()
{
  println("Game Over!\n");
  JOptionPane.showMessageDialog(null, assassin.getAssassinName() + ",your practice is over!\n\n"
    + "Number of practice sessions: " + numberOfGamesPlayed
    + "\n\n"       + assassin.toString()
    + "\n\nHighest Score: "   + assassin.highestScore()
    +  "\nAverage Score: "   + assassin.averageScore());
  exit();
}

//method returns true if the enemy and the target overlap 
//(i.e. target shoots the enemy) false otherwise.
boolean hitTarget(Target target, Enemy enemy)
{
  //Variables measure the ma  gnitude of the gap between the enemy and the target.
  float circleDistanceX = abs(target.getTargetX() - enemy.getEnemyX());
  float circleDistanceY = abs(target.getTargetY() - enemy.getEnemyY() - enemy.getDiameter()/2);

  //The enemy is out of range from the Target on the X axis, so no collision detection
  if (circleDistanceX > (enemy.getDiameter()/2)) {
    return false;
  }

  //The enemy is too far away from the target on the Y axis to  have a collision, 
  //so abandon collision detection
  if (circleDistanceY > (target.getTargetWidth()/2 + enemy.getDiameter()/2)) {
    return false;
  }
  //We have a collision!
  return true;
}
