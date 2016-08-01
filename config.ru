require 'sinatra'
require './game.rb'


game = {
  "player1": "",
  "player2": "",
  "board": ["_","_","_","_","_","_","_","_","_"]
}


InvalidTokenError = Class.new(Exception)
get '/' do
    <<-TEXT
      This is a sample get route that I will use to test some variables, dependencies, etc. \n
      So, we need an ENV property for SLACK_TOKEN -> #{ENV['SLACK_TOKEN']}
      We need a parameter value of the token #{params[:token]}
    TEXT
end

post '/' do
  # raise(InvalidTokenError) unless params[:token] == ENV['SLACK_TOKEN']
  user = params.fetch('user_name')
  text = params.fetch('text').strip

  case text

  when 'create'

    <<-TEXT
      Hi there, #{user}, you have chosen to create a new game against ___!
    TEXT

  when 'display'
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



run Sinatra::Application
