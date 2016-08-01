require 'sinatra'
require './game.rb'

InvalidTokenError = Class.new(Exception)

post '/' do
  raise(InvalidTokenError) unless params[:token] == ENV['SLACK_TOKEN']
  # token = params[:token]
  user = params.fetch('user_name')
  text = params.fetch('text').strip

  case text

  when 'when'

    <<-TEXT
      The next Hey! event will be held on the 20th May from 7:30pm at The Belgrave in central Leeds.

      Hopefully see you then #{user}!

      http://hey.wearestac.com/
    TEXT

  else

    'Unknown command :cry:. Please type "/slacktactoe help" for more info.'

  end
end

run Sinatra::Application
