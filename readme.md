# SlackTacToe

This is a [Slack](https://slack.com) bot example written in Sinatra.

It was written with the help of [this blog post](http://wearestac.com/blog/building-a-slack-slash-command-with-sinatra-finch-and-heroku).

The application has been deployed to heroku under the URL of https://slacktactoe.herokuapp.com/ and configured in Slack so that it can be accessed like so:

* `/slacktactoe challenge` - This will start a new game
* `/slacktactoe display` - This will display the current state of the board
* `/slacktactoe mark :mark` - This will take a location on the board numbered 1-9 where 1 is the upper left and 9 is the bottom right.
* `/slacktactoe display` - This will display the current state of the board
* `/slacktactoe unsupportedcommand` - Respond to missing commands with a friendly error message