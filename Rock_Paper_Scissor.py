HW1: Rock Paper Scissor game player vs com
import random
def rps_game():
    options = ("rock", "paper","scissor")
    player_score = 0
    com_score = 0

    while True:
        player = input("Please choose rock, scissor, or paper (or 'quit' to exit): ").lower()
      ##check valid input
        if player not in options and player !="quit":
            print("invalid input. Please try again.")
            continue
        if player == "quit":

            #print final score
            print("Final score: ")
            print(f" You: {player_score}")
            print(f" Com: {com_score}")

            if player_score > com_score:
                print("\n Wow! You Won!!")
            elif player_score < com_score:
                print("\n You Lose!")
            else:
                print("The game end in Tie")
            break
        com = random.choice(options)

        if player == com:
            print("Tie!")
        elif    (player == "rock" and com == "scissor") or \
                (player == "scissor" and com == "paper") or \
                (player == "paper" and com == "rock"):
            print("You Win!")
            player_score += 1
        else:
            print("You Lose!.")
            com_score +=1

rps_game()
