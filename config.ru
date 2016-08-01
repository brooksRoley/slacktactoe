require 'sinatra'

InvalidTokenError = Class.new(Exception)

get '/' do
    <<-TEXT
This is a get example
TEXT

end

post '/' do
  raise(InvalidTokenError) unless params[:token] == ENV['SLACK_TOKEN']

  user = params.fetch('user_name')
  text = params.fetch('text').strip

  case text
  when 'when'

    <<-TEXT
The next Hey! event will be held on the 20th May from 7:30pm at The Belgrave in central Leeds.

Hopefully see you then #{user}!

http://hey.wearestac.com/
TEXT

  when 'what'

    <<-TEXT
The next Hey! event has two lectures planned. The first one is with Rich Fiddaman discussing everything hospitality. The second is with Matt Dix discussing Leeds Indie Food Festival.

http://hey.wearestac.com/lectures/a-pint-with-the-pub-landlord

http://hey.wearestac.com/lectures/kickstarting-a-city-wide-food-festival
TEXT

  else

    'Unknown command :cry:'

  end
end

run Sinatra::Application
