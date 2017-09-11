monty <- function(strat = 'stay',
                  N = 1000,
                  print_games = TRUE)
{
  doors <- 1:3 #initialize the doors behind one of which is a good prize
  win <- 0 #to keep track of number of wins
  
  for (i in 1:N)
  {
    prize <- floor(runif(1, 1, 4)) #randomize which door has the good prize
    guess <- floor(runif(1, 1, 4)) #guess a door at random
    
    ## Reveal one of the doors you didn't pick which has a bum prize
    if (prize != guess)
      reveal <- doors[-c(prize, guess)]
    else
      reveal <- sample(doors[-c(prize, guess)], 1)
    
    ## Stay with your initial guess or switch
    if (strat == 'switch')
      select <- doors[-c(reveal, guess)]
    if (strat == 'stay')
      select <- guess
    if (strat == 'random')
      select <- sample(doors[-reveal], 1)
    
    ## Count up your wins
    if (select == prize)
    {
      win <- win + 1
      outcome <- 'Winner!'
    } else
      outcome <- 'Losser!'
    
    if (print_games)
      cat(
        paste(
          'Guess: ',
          guess,
          '\nRevealed: ',
          reveal,
          '\nSelection: ',
          select,
          '\nPrize door: ',
          prize,
          '\n',
          outcome,
          '\n\n',
          sep = ''
        )
      )
  }
  cat(
    paste(
      'Using the ',
      strat,
      ' strategy, your win percentage was ',
      win / N * 100,
      '%\n',
      sep = ''
    )
  ) #Print the win percentage of your strategy
}





# define all of our functions at the top
strat = 'switch'
N  <-  1000
print_games  <-  TRUE
doors <- 1:3 # initialize the doors behind one of which is a good prize
win <- 0 # to keep track of number of wins

for (i in 1:N) {
  prize <- sample(1:3, 1) # randomize which door has the good prize
  guess <- sample(1:3, 1) # guess a door at random
  
  # Reveal one of the doors you didn't pick which has a bum prize
  if (prize != guess) {
    reveal <- doors[-c(prize, guess)] # show the remaining goat
  } else {
    reveal <- sample(doors[-c(prize, guess)], 1) # show one of 2 doors w/ goats
  }
  
  # Stay with your initial guess or switch
  if (strat == 'switch') {
    select <- doors[-c(reveal, guess)]
  }
  if (strat == 'stay') {
    select <- guess
  }
  if (strat == 'random') {
    select <- sample(doors[-reveal], 1)
  }
  
  # Count up your wins
  if (select == prize) {
    win <- win + 1
    outcome <- 'Winner!'
  } else {
    outcome <- 'Losser!'
  }
  
}
win / N











# the final version for week 4 -- 



# define all of our functions at the top
strat = 'switch'
N  <-  1000
print_games  <-  TRUE
doors <- 1:3 # initialize the doors behind one of which is a good prize
win <- 0 # to keep track of number of wins

for (i in 1:N) {
  prize <- sample(1:3, 1) # randomize which door has the good prize
  guess <- sample(1:3, 1) # guess a door at random
  
  # Reveal one of the doors you didn't pick which has a bum prize
  if (prize != guess) {
    reveal <- doors[-c(prize, guess)] # show the remaining goat
  } else {
    reveal <- sample(doors[-c(prize, guess)], 1) # show one of 2 doors w/ goats
  }
  
  # Stay with your initial guess or switch
  if (strat == 'switch') {
    select <- doors[-c(reveal, guess)]
  }
  if (strat == 'stay') {
    select <- guess
  }
  if (strat == 'random') {
    select <- sample(doors[-reveal], 1)
  }

  # Count up your wins
  if (select == prize) {
    win <- win + 1
    outcome <- 'Winner!'
  } else {
    outcome <- 'Losser!'
  }

}
win / N


