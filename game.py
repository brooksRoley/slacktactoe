import sys
board = [
              "_", "_", "_",
              "_", "_", "_",
              "_", "_", "_"
            ]

# I am going to want to change these player1 and 2 to slack usernames.

def mark(board, square, turn):
  player = players_turn(turn)
  while board[square-1] != "_":
    print("That square is taken.")
    square = get_square()
  board[square-1] = player


def players_turn(turn):
    pieces = ["X", "O"]
    return pieces[turn % 2]

def draw_board():
  print(" %s | %s | %s " % (board[0],board[1],board[2]))
  print(" %s | %s | %s " % (board[3],board[4],board[5]))
  print(" %s | %s | %s " % (board[6],board[7],board[8]))
# def take_turn():
#   print("Where would you like to place your piece?")
def get_square():
  square = 0
  while square not in range(1,9):
    square = input(
        "Please input the number of the square on which you'd like to play.\nYour input should be a number within the range of 1-9\nwhere 1 corresponds to the top left square and 9 corresponds to the bottom right square.\nLike a phone. All telephones have the same number scheme, right? Hold on let me google it. Yeah, all telephones do use the same number scheme except for those cool guys with the circular dial.\n"
    )
    return square

def check_win(board, turn):
  piece = players_turn(turn)
  print(piece)
  # This is a ugly brute force way to check against 8 possible win conditions. If any of the lines match the piece of the player whose turn it is, Print a win message and exit the game.
  did_win = all(x == piece for x in (board[0], board[1], board[2])) or all(x == piece for x in (board[3],  board[4],  board[5])) or all(x == piece for x in (board[6],  board[7],  board[8])) or all(x == piece for x in (board[0],  board[3],  board[6])) or all(x == piece for x in (board[1],  board[4],  board[7])) or all(x == piece for x in (board[2],  board[5],  board[8])) or all(x == piece for x in (board[0],  board[4],  board[8])) or all(x == piece for x in (board[6],  board[4],  board[2]))

  if did_win:
      print("Congratulations player %d on a well fought win." % (turn%2 +1))
      sys.exit()

for i in range(9):
  square = get_square()
  mark(board, square, i)
  draw_board()
  if(check_win(board, i)):
    sys.exit(0)

