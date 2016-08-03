require 'sinatra'

class Game
  attr_accessor :players, :board, :turn
  def initialize(player1, player2)
    @players = []
    @players[0] = player1
    @players[1] = player2
    @board = ["__","__","__","__","__","__","__","__","__"]
    @turn = 1
  end
end
current_game = Game.new("me", "you")

InvalidTokenError = Class.new(Exception)

get '/' do
    <<-TEXT
      This is a sample get route that I will use to test some variables, dependencies, etc. \n
      Player1: #{current_game.players[0]} \n
      Player2: #{current_game.players[1]} \n
      Board: #{current_game.board} \n
    TEXT
end

post '/' do
  token = params.fetch('token')
  raise(InvalidTokenError) unless token == ENV['SLACK_TOKEN']
  user = params.fetch('user_name')
  text = params.fetch('text').strip.split(" ")
  command = text[0]

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
        Hi #{user}, you have chosen to create a new game against #{current_game.players[1]}! \n
        Let's begin. \n
        [  #{current_game.board[0]}    #{current_game.board[1]}    #{current_game.board[2]}  ]\n
        [  #{current_game.board[3]}    #{current_game.board[4]}    #{current_game.board[5]}  ]\n
        [  #{current_game.board[6]}    #{current_game.board[7]}    #{current_game.board[8]}  ]\n
      TEXT
    end

  when 'display'
    turn = current_game.turn
    current_player = current_game.players[(turn-1)%2]
    opponent_player = current_game.players[(turn)%2]
    <<-TEXT
      It is currently #{current_player}'s turn playing against #{opponent_player}. \n
        [  #{current_game.board[0]}    #{current_game.board[1]}    #{current_game.board[2]}  ]\n
        [  #{current_game.board[3]}    #{current_game.board[4]}    #{current_game.board[5]}  ]\n
        [  #{current_game.board[6]}    #{current_game.board[7]}    #{current_game.board[8]}  ]\n
    TEXT

  when 'mark'
    move_location = text[1].to_i
    if move_location < 1 || move_location > 9
      <<-TEXT
        Invalid Input: You must type '/slacktactoe move number' \n
        The number should be within the range of 1-9 where 1 corresponds to the top left square and 9 corresponds to the bottom right square.\n
        Like a phone... All telephones have the same number scheme, right? Hold on let me google it. Yeah, all telephones do use the same number scheme except for those cool guys with the circular dial.\n"
      TEXT
    # elsif user != current_game.players[(turn-1) % 2]
    #   <<-TEXT
    #     It is not your turn.
    #   TEXT
    else
    #   pieces = ["X", "O"]
    #   piece = pieces[current_game.turn % 2]
    #   current_game.turn += 1
    #   current_game.board[move_location-1] = piece
      next_turn = current_game.players[(current_game.turn-1)%2]
      <<-TEXT
        It is now #{next_turn}'s Turn.
        [  #{current_game.board[0]}    #{current_game.board[1]}    #{current_game.board[2]}  ]\n
        [  #{current_game.board[3]}    #{current_game.board[4]}    #{current_game.board[5]}  ]\n
        [  #{current_game.board[6]}    #{current_game.board[7]}    #{current_game.board[8]}  ]\n
      TEXT
    end
  else
    'Unknown command :cry:. Please type "/slacktactoe help" for more info.'
  end

end

run Sinatra::Application
