/*
Name : Adelle McAteer 
 Student Number: 20091411
 */

public class Assassin 
{
  private String assassinName;     //Create the string name
  private int[] shots;             //Array to store the number of enemies killed
  private int count;               //to keep track of the high score

  public int highestScore()      //method to provide the highest score
  {  
    int highestScore = shots[0];
    for (int i = 1; i < count; i++) {
      if (shots[i] > highestScore) {
        highestScore = shots[i];
      }
    }

    return highestScore;
  } 

  //method calculates and returns the average of all the high 
  //scores stored in the shots array
  public int averageScore()
  {
    int total = 0;
    for (int i = 0; i < count; i++) {
      total = total + shots[i];
    }
    return total / count;
  }

  //Constructor to create the assassin details with a starting name and sets the size of the array
  //to the number of games in the practice session, as entered by the player.
  public Assassin(String assassinName, int numberOfGames) 

    //string to print the user input 
  {
    this.assassinName = assassinName;   
    shots = new int[numberOfGames];
    count = 0;
  }

  //accessors
  public String getAssassinName()
  {
    return assassinName;
  }
  //mutator for number of enemies killed/high score array
  public int[]getKills()
  {
    return shots;
  }

  //mutator for player name
  public void setAssassinName(String assassinName)
  {
    this.assassinName = assassinName;
  }

  public void setShots(int[] shots)
  {
    this.shots = shots;
  }
  //method to add number of successful shots at the next available location in the scores array
  public void addShot(int shot)
  {
    if (shot >= 0) {
      shots[count] = shot;
      count++;
    }
  }

  //method builds a nice String representation of the assassin name and their high scores
  public String toString()
  {
    String str = "Enemies shot by " +assassinName + "\n";

    for (int i = 0; i < count; i++) {
      str = str + "Enemies shot " + (i+1) + ":" + shots[i] + "\n";
    }
    return str;
  }
}
