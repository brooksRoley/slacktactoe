require 'sinatra'

class Game
  attr_accessor :player1, :player2, :board
  def initialize(player1, player2)
    @player1  = player1
    @player2  = player2
    @board = ["_","_","_","_","_","_","_","_","_"]
  end
end
current_game = Game.new("me", "you")

InvalidTokenError = Class.new(Exception)

get '/' do
    <<-TEXT
      This is a sample get route that I will use to test some variables, dependencies, etc.
      #{current_game.player1} \n
      #{current_game.player2} \n
      #{current_game.board} \n
    TEXT
end

post '/' do
  token = params.fetch('token')
  user = params.fetch('user_name')
  text = params.fetch('text').strip.split(" ")
  command = text[0]
  # arguement = text[1]
  raise(InvalidTokenError) unless token == ENV['SLACK_TOKEN']

  case command

  when 'create'
    opponent = "tbd"
    # current_game = Game.new(user, opponent)
    <<-TEXT
      Hi there, #{user}, you have chosen to create a new game against #{opponent}!
    TEXT

  when 'display'
    board = current_game.board
    board = board || [1,2,3]
    <<-TEXT
      #{board}
      It is ____'s turn.
    TEXT

  when 'move'
    if user == "the user whose turn it is"
      <<-TEXT
        Users can specify their next move, which also publicly displays the board in the channel after the move with a reminder of whose turn it is.
      TEXT
    else
      <<-TEXT
        It is not your turn.
      TEXT
    end
    # When a turn is taken that ends the game, the response indicates this along with who won.

  when 'two words'
    <<-TEXT
      successfully saw two words, spaces are acceptable in text.
    TEXT
  else

    'Unknown command :cry:. Please type "/slacktactoe help" for more info.'
  end

end



def draw_board()
    <<-TEXT
      #{board[0]}  |  #{board[1]}  |  #{board[2]}
      #{board[3]}  |  #{board[4]}  |  #{board[5]}
      #{board[6]}  |  #{board[7]}  |  #{board[8]}
    TEXT
end

run Sinatra::Application
