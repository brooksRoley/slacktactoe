require 'sinatra'

class Game
  attr_accessor :player1, :player2, :board
  def initialize(player1, player2)
    @player1  = player1
    @player2  = player2
    @board = ["__","__","__","__","__","__","__","__","__"]
  end
end
current_game = Game.new("me", "you")


def draw_board()
    # <<-TEXT
    #   #{board[0]}  |  #{board[1]}  |  #{board[2]}
    #   #{board[3]}  |  #{board[4]}  |  #{board[5]}
    #   #{board[6]}  |  #{board[7]}  |  #{board[8]}
    # TEXT
    "from function"
end


InvalidTokenError = Class.new(Exception)

get '/' do
    <<-TEXT
      This is a sample get route that I will use to test some variables, dependencies, etc. \n
      Player1: #{current_game.player1} \n
      Player2: #{current_game.player2} \n
      Board: #{current_game.board} \n
    TEXT
end

post '/' do
  token = params.fetch('token')
  user = params.fetch('user_name')
  text = params.fetch('text').strip.split(" ")
  command = text[0]
  raise(InvalidTokenError) unless token == ENV['SLACK_TOKEN']

  case command

  when 'challenge'
    if text.length != 2
      <<-TEXT
        You've input the create command incorrectly. It should be '/slacktactoe create opponentsUsername'
      TEXT
    else
      opponent = text[1]
      current_game = Game.new(user, opponent)
      <<-TEXT
        Hi #{user}, you have chosen to create a new game against #{current_game.player2}! \n
        Let's begin. \n

        [  __    __    __  ]\n
        [  __    __    __  ]\n
        [  __    __    __  ]\n


      TEXT
    end

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

run Sinatra::Application
