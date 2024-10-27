#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
RANDOM_NUMBER=$((1 + RANDOM % 1000 ))


echo Enter your username: 
read USERNAME
#Checking user info
USER_INFO=$($PSQL "Select * From users Where username='$USERNAME'")
#echoing sentences based on USER_INFO
if [[ -z $USER_INFO ]]; then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
fi

echo Guess the secret number between 1 and 1000:
read NUMBER_GUESS
#adding while loop for the game
while [[ $USERNAME != $RANDOM_NUMBER
