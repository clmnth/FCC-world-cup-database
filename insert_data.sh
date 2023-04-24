#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE teams, games")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do 
 if [[ $WINNER != winner ]]
    then 

    # get winner_id
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='WINNER_ID'") 
      echo $WINNER_ID

      # if not found
       if [[ -z $WINNER_ID ]]
           then
            # insert name
            INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
             if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
                then
                echo "Inserted into teams, $WINNER"
             fi

              # get new team_id
              WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

        fi

   # get opponent_id
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='OPPONENT_ID'") 
      echo $OPPONENT_ID

      # if not found
       if [[ -z $OPPONENT_ID ]]
           then
            # insert name
            INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
             if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
                then
                echo "Inserted into teams, $OPPONENT"
             fi

              # get new team_id
              OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

        fi

  
  fi
  done
