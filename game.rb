# This is a test file where I converted pieces of the tic tac toe game I originally wrote in Python into Ruby for easier implementation inside of the SlackTacToe slash command not all pieces were converted from Python as not every piece of code was applicable inside of the slash command framework.

board = [
        "_", "_", "_",
        "_", "_", "_",
        "_", "_", "_"
      ]

def players_turn(turn)
  pieces = ["X", "O"]
  return pieces[turn % 2]
end

def mark(board, square, turn)
  player = players_turn(turn)
  while board[square-1] != "_" do
    print("That square is taken.")
    square = get_square()
  end
  board[square-1] = player
end

def draw_board()
  puts "  #{board[0]}  |  #{board[1]}  |  #{board[2]}  "
  puts "  #{board[3]}  |  #{board[4]}  |  #{board[5]}  "
  puts "  #{board[6]}  |  #{board[7]}  |  #{board[8]}  "
end

# def take_turn():
#   print("Where would you like to place your piece?")
def get_square()
  square = 0
  while (square <= 1 || square >= 9) do
      puts "Please input the number of the square on which you'd like to play.\nYour input should be a number within the range of 1-9\nwhere 1 corresponds to the top left square and 9 corresponds to the bottom right square.\nLike a phone. All telephones have the same number scheme, right? Hold on let me google it. Yeah, all telephones do use the same number scheme except for those cool guys with the circular dial.\n"
      square = gets.to_i
    end
    return square
end

def check_win(board, turn)
  piece = players_turn(turn)
  did_win = %w[board[0], board[1], board[2]].all?{|x| x==piece} or %w[board[3],  board[4], board[5]].all?{|x| x==piece} or %w[board[6], board[7], board[8]].all?{|x| x==piece} or %w[board[0], board[3], board[6]].all?{|x| x==piece} or %w[board[1], board[4], board[7]].all?{|x| x==piece} or %w[board[2], board[5],  board[8]].all?{|x| x==piece} or %w[board[0], board[4], board[8]].all?{|x| x==piece} or %w[board[6], board[4], board[2]].all?{|x| x==piece}
  if did_win
      print("Congratulations player %d on a well fought win." % (turn%2 +1))
      # sys.exit()
  end
end


# board.each_with_index do |x, i|
#   square = get_square()
#   mark(board, square, i)
#   draw_board()
#   if(check_win(board, i))
#     # sys.exit(0)
#   end
# end
