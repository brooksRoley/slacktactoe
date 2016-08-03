# SlackTacToe

This is a [Slack](https://slack.com) bot example written in Sinatra that allows the user to play Tic Tac Toe in the channel. It was a coding challenge given to Brooks Roley for the position of Application Engineer at Slack.

It was written with the help of [this blog post](http://wearestac.com/blog/building-a-slack-slash-command-with-sinatra-finch-and-heroku). Additional thanks to [this blog's style guide](https://medium.com/slack-developer-blog/slash-commands-style-guide-4e91272aa43a#.lx5ecndad)

If you would like to play the game in your terminal instead, there is a python file contained named game.py that is fully functional.

The application has been deployed to heroku under the URL of https://slacktactoe.herokuapp.com/ and configured in my challenge's Slack channel.

It can be accessed like so after the integration is added to a team's slack channel:

* `/slacktactoe challenge :opponent's_username` - This will start a new game
* `/slacktactoe display` - This will display the current state of the board
* `/slacktactoe mark :square` - This will take a location on the board numbered 1-9 where 1 is the upper left and 9 is the bottom right.
* `/slacktactoe help` - You seem to know how this one works.
* `/slacktactoe unsupportedcommand` - Respond to missing commands with a friendly error message


Future Releases:

- Allow the user's to select their pieces instead of defaulting to X and O.
  This would move the pieces array onto the game object and create a command to set this to an ascii character.
- Use the 'user.list' to make sure the person you challenge is indeed a user of the channel.
  https://api.slack.com/methods/users.list
- Put the board into a database so the state persists across server shutdowns and restarts.
- Refactor the mark route so as not to duplicate text code.
- Write logic for a won or tied game that is smarter than wiping the board.
- Figure out why function calls within config.ru cause a SIGTERM.
- Create a scoreboard to track how many wins/draws/losses each member of the channel has.
- Implement a simple AI so that the channel can play back.
- Organize some of the output into the response object's 'attachment' property for an improved view.

List of tests to meet requirements:

  1. Users can create a new game in any Slack channel by challenging another user (using their username).
    /slacktactoe challenge opponent

  Note: Mentioned in the 'Future Release' notes, this could reference slack's user.list API to make sure the opponent exists.
  As of right now, if you incorrectly type in your opponent's name, you will have to create a new game as no player will be able to take that player's moves.

  2. A channel can have at most one game being played at a time.
    /slacktactoe challenge different_opponent

  Note: I made the decision to overwrite the existing game if a user created a new game for a few reasons.
  This meets the single game requirement and user's can only complete a game if they input a real opponent's name. This allows them to rectify a mistake easily if they do not.

  3. Anyone in the channel can run a command to display the current board and list whose turn it is.
    /slacktactoe display

  Note:

  4. Users can specify their next move, which also publicly displays the board in the channel after the move with a reminder of whose turn it is.
    /slacktactoe move 1

  Note:

  5. Only the user whose turn it is can make the next move.
    /slacktactoe move 1

  Note:

  6. When a turn is taken that ends the game, the response indicates this along with who won.
    /slacktactoe move [0,1,2]

  Note: There are 8 possible ways to win a game. The route will ouput the finishing board and a congratulatory message then reset the game state to before a challenge was posed.