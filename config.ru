require 'sinatra'
require 'json'

class Game
  attr_accessor :players, :pieces, :board, :turn
  def initialize(player1, player2)
    @players = []
    @players[0] = player1
    @players[1] = player2
    @pieces = ["X", "O"]
    @board = ["__","__","__","__","__","__","__","__","__"]
    @turn = 1
  end
end

current_game = Game.new("I", "you")
InvalidTokenError = Class.new(Exception)

get '/' do
    <<-TEXT
      This is a sample get route that I will use to test some variables, dependencies, etc. \n
      The Current game being played is listed below.\n
      Player1: #{current_game.players[0]} \n
      Player2: #{current_game.players[1]} \n
      [  #{current_game.board[0]}    #{current_game.board[1]}    #{current_game.board[2]}  ]\n
      [  #{current_game.board[3]}    #{current_game.board[4]}    #{current_game.board[5]}  ]\n
      [  #{current_game.board[6]}    #{current_game.board[7]}    #{current_game.board[8]}  ]\n

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
        You've input the challenge command incorrectly. It should be '/slacktactoe challenge opponentsUsername'
      TEXT
    else
      opponent = text[1]
      current_game = Game.new(user, opponent)
      <<-TEXT
        Hi #{user}, you have chosen to create a new game against #{current_game.players[1]}! \n
        Because you have cast the gauntlet, you will play first. \n
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
    response = {
       :response_type => "ephemeral",
       :text => "It is about to be turn #{turn}. #{current_player} will play against #{opponent_player}. \n
        [  #{current_game.board[0]}    #{current_game.board[1]}    #{current_game.board[2]}  ]\n
        [  #{current_game.board[3]}    #{current_game.board[4]}    #{current_game.board[5]}  ]\n
        [  #{current_game.board[6]}    #{current_game.board[7]}    #{current_game.board[8]}  ]\n"
    }.to_json

  when 'mark'
    move_location = text[1].to_i
    # puts "LOG Square- #{current_game.board[move_location-1]}"
    # puts "LOG location- #{move_location-1}"
    # puts "LOG Board- #{current_game.board}"
    if move_location < 1 || move_location > 9
      <<-TEXT
        Invalid Input: You must type '/slacktactoe mark number' \n
      The number should be within the range of 1-9 where 1 corresponds to the top left square and 9 corresponds to the bottom right square.\n
      Like a phone... All telephones have the same number scheme, right? Hold on let me google it. Yeah, all telephones do use the same number scheme except for those cool guys with the circular dial.\n
      TEXT
    elsif user != current_game.players[(current_game.turn-1) % 2]
      <<-TEXT
        #{user}, it is not your turn.
      TEXT

    elsif current_game.board[move_location-1] != "__"
      <<-TEXT
        Please input a square that is not already taken.
      TEXT
    else
      piece = current_game.pieces[current_game.turn % 2]
      current_game.board[move_location-1] = piece
      did_win =
        [current_game.board[0], current_game.board[1], current_game.board[2]].all?{|x| x==piece} ||
        [current_game.board[3], current_game.board[4], current_game.board[5]].all?{|x| x==piece} ||
        [current_game.board[6], current_game.board[7], current_game.board[8]].all?{|x| x==piece} ||
        [current_game.board[0], current_game.board[3], current_game.board[6]].all?{|x| x==piece} ||
        [current_game.board[1], current_game.board[4], current_game.board[7]].all?{|x| x==piece} ||
        [current_game.board[2], current_game.board[5], current_game.board[8]].all?{|x| x==piece} ||
        [current_game.board[0], current_game.board[4], current_game.board[8]].all?{|x| x==piece} ||
        [current_game.board[6], current_game.board[4], current_game.board[2]].all?{|x| x==piece}

      if did_win
        current_player = current_game.players[(current_game.turn)%2]
        <<-TEXT
          Congratulations, #{current_player}, on a well fought win. \n
        Turn: #{current_game.turn-1} \n
        [  #{current_game.board[0]}    #{current_game.board[1]}    #{current_game.board[2]}  ]\n
        [  #{current_game.board[3]}    #{current_game.board[4]}    #{current_game.board[5]}  ]\n
        [  #{current_game.board[6]}    #{current_game.board[7]}    #{current_game.board[8]}  ]\n
        TEXT
      elsif current_game.turn > 9
        <<-TEXT
          The game has ended as a tie. You may restart using the 'challenge' command. \n
        Turn: #{current_game.turn-1} \n
        [  #{current_game.board[0]}    #{current_game.board[1]}    #{current_game.board[2]}  ]\n
        [  #{current_game.board[3]}    #{current_game.board[4]}    #{current_game.board[5]}  ]\n
        [  #{current_game.board[6]}    #{current_game.board[7]}    #{current_game.board[8]}  ]\n
        TEXT
      else
        current_game.turn += 1
        next_turn = current_game.players[(current_game.turn-1)%2]
        <<-TEXT
          It is now #{next_turn}'s turn. \n
        Turn: #{current_game.turn-1} \n
        [  #{current_game.board[0]}    #{current_game.board[1]}    #{current_game.board[2]}  ]\n
        [  #{current_game.board[3]}    #{current_game.board[4]}    #{current_game.board[5]}  ]\n
        [  #{current_game.board[6]}    #{current_game.board[7]}    #{current_game.board[8]}  ]\n
        TEXT
      end
    end

  when 'help'
    <<-TEXT
    * `/slacktactoe challenge :opponent's_username` - This will start a new game
    * `/slacktactoe display` - This will display the current state of the board
    * `/slacktactoe mark :square` - This will take a location on the board numbered 1-9 where 1 is the upper left and 9 is the bottom right.
    * `/slacktactoe help` - You seem to know how this one works.
    * `/slacktactoe unsupportedcommand` - Respond to missing commands with a friendly error message
    TEXT
  else
    'Unknown command :cry:. Please type "/slacktactoe help" for more info.'
  end

end

run Sinatra::Application
