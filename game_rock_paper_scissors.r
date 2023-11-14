##game rock - paper-scissors
moves <- c("rock","paper","scissors")
player_score <- 0
com_score <-0

##com vs player
game <- function(){
  while (TRUE) {
    print("Your turn (rock, paper, scissors) or Quit(q)")
    player <- readLines("stdin", n=1)
    
    if (player=="q"){
      print(paste("player_score",player_score))
      print(paste("com_score",com_score))
      if(player_score>com_score){
        print("Final : You Win")
      } else if(player_score == com_score){
        print("Final : You Tied")
      } else {
        print("Final : You Lost")
      }
      break
      } else if (player %in% moves){
      com <-sample(moves, 1)
            
      if (player == com){
      print("You Tied.")
      } else if ((player == "scissors"&& com=="paper") ||
                (player == "paper"&& com=="rock") ||
                (player == "rock"&& com=="scissors")) {
      print("You Win!")
      player_score <-player_score + 1
      } else {
        print ("You Lost")
        com_score <-com_score + 1
        }
      } else {
      print ("please choose rock, paper, scissors or q")
    }
  }
}


game()
