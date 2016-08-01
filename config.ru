require 'sinatra'
require './game.rb'

InvalidTokenError = Class.new(Exception)

get '/' do
    <<-TEXT
      This is a get example
    TEXT
end

post '/' do
  # raise(InvalidTokenError) unless params[:token] ==d ENV['SLACK_TOKEN']
  token = params[:token]
  user = params.fetch('user_name')
  text = params.fetch('text').strip

  say()
  "this is a sample to see if I can print #{token} here"

  case text

  when 'when'

    <<-TEXT
      The next Hey! event will be held on the 20th May from 7:30pm at The Belgrave in central Leeds.

      Hopefully see you then #{user}!

      http://hey.wearestac.com/
    TEXT

  else

    'Unknown command :cry:'

  end
end

run Sinatra::Application
