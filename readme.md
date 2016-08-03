# SlackTacToe

This is a [Slack](https://slack.com) bot example written in Sinatra that allows the user to play Tic Tac Toe in the channel. It was a coding challenge given to Brooks Roley for the position of Application Engineer at Slack.

It was written with the help of [this blog post](http://wearestac.com/blog/building-a-slack-slash-command-with-sinatra-finch-and-heroku).

The application has been deployed to heroku under the URL of https://slacktactoe.herokuapp.com/ and configured in my challenge's Slack channel.

It can be accessed like so after the integration is added to a team's slack channel:

* `/slacktactoe challenge :opponent's_username` - This will start a new game
* `/slacktactoe display` - This will display the current state of the board
* `/slacktactoe mark :square` - This will take a location on the board numbered 1-9 where 1 is the upper left and 9 is the bottom right.
* `/slacktactoe help` - You seem to know how this one works.
* `/slacktactoe unsupportedcommand` - Respond to missing commands with a friendly error message


Future Releases:

- Allow the user's to select their pieces instead of the default X and O.
  This would move the pieces array onto the game object and create a command to set this to an ascii character.
- Use the 'user.list' to make sure the person you challenge is indeed a user of the channel.
  https://api.slack.com/methods/users.list
- Put the board into a database so the state persists across server shutdowns and restarts.