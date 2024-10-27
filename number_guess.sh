#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
RANDOM_NUMBER=$((1 + RANDOM % 1000 ))
#Variables
GAMES_PLAYED=0
BEST_GAME=0
NUMBER_OF_GUESSES=0

echo Enter your username: 
read USERNAME
#Checking user info
USER_INFO=$($PSQL "Select * From users Where username='$USERNAME'")
#echoing sentences based on USER_INFO
if [[ -z $USER_INFO ]]; then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  $GAMES_PLAYED=$($PSQL "Select games_played From users Where username='$USERNAME'")
  $BEST_GAME=$($PSQL "Select best_game From users Where username='$USERNAME'")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi
#Game logic
echo Guess the secret number between 1 and 1000:
read NUMBER_GUESS
echo $RANDOM_NUMBER
NUMBER_OF_GUESSES=1
#adding while loop for the game
while [[ $NUMBER_GUESS != $RANDOM_NUMBER ]]; do
  if [[ $NUMBER_GUESS =~ ^[0-9]+$ ]]; then
    if [[ $NUMBER_GUESS -gt $RANDOM_NUMBER ]]; then
      echo "It's lower than that, guess again:"
      ((NUMBER_OF_GUESSES++))
    elif [[ $NUMBER_GUESS -lt $RANDOM_NUMBER ]]; then
      echo "It's higher than that, guess again:"
      ((NUMBER_OF_GUESSES++))
    fi
  else
    echo That is not an integer, guess again:
  fi
  read NUMBER_GUESS
done

echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $RANDOM_NUMBER. Nice job!"


