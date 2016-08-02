require 'sinatra'

game = {
  "player1": "",
  "player2": "",
  "board": ["_","_","_","_","_","_","_","_","_"]
}


InvalidTokenError = Class.new(Exception)

get '/' do
    <<-TEXT
      This is a sample get route that I will use to test some variables, dependencies, etc.
    TEXT
end

post '/' do
  # raise(InvalidTokenError) unless params[:token] == ENV['SLACK_TOKEN']
  puts "[LOG - params] #{params}"
  draw_board
  user = params.fetch('user_name')
  text = params.fetch('text').strip
  token = params.fetch('token')

  case text

  when 'create'

    <<-TEXT
      Token: #{token} \n
      Hi there, #{user}, you have chosen to create a new game against ___!
    TEXT

  when 'display'
    board = "Get the board somehow. Persist."
    <<-TEXT
      The current state of your board is #{board}

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
  else

    'Unknown command :cry:. Please type "/slacktactoe help" for more info.'

  end
end



def draw_board()
  puts "drawing board"
  <<-TEXT
    #{board[0]}  |  #{board[1]}  |  #{board[2]}
    #{board[3]}  |  #{board[4]}  |  #{board[5]}
    #{board[6]}  |  #{board[7]}  |  #{board[8]}
  TEXT
  return <<-TEXT pizza TEXT
end

run Sinatra::Application
