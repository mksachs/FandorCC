FandorCC
=========

The challenge: create a Tetris simulation with only the 2x2 block using Ruby
and test-driven development.

The approach represented here to solving this problem involves choosing block
locations that minimize 'energy'. Being lower on the board, along one of the
side walls, or adjacent to another element are considered low-energy states.

For example, consider the following configuration:


|          |
|        xx|
|        xx|
------------

This would be lower energy than this configuration:

|          |
|       xx |
|       xx |
------------

Given a choice between the two, the code will chose the former. 

This results in the game being played as follows:

|          |
|          | <-------------------------------------------------------
|          |                                                        |
------------                                                        |
     |                                                              |
     \/                                                             |
|          |    |          |    |          |    |          |    |          |
|11        | -> |1122      | -> |112233    | -> |11223344  | -> |1122334455|
|11        |    |1122      |    |112233    |    |11223344  |    |1122334455|
------------    ------------    ------------    ------------    ------------

This implementation is designed to accept the inclusion of additional shapes.


Contents
---------

lib/tetris.rb - Class to manage the playing of a Tetris game.
lib/tetrimino.rb - Class defining the blocks used in a Tetris game.
spec/tetris_spec.rb - RSpec unit tests for the Tetris class.
spec/tetrimino_spec.rb - RSpec unit test for the Tetrimino class.


Usage
---------

For the unit tests:

rspec spec/tetris_spec.rb
rspec spec/tetris_spec.rb

To run a game:

'''ruby
require_relative "lib/tetris.rb"
tg = Tetris.new
# Will drop 13 blocks and then stop and print out the board. The game will never
# lose as currently designed.
tg.play(13)
'''