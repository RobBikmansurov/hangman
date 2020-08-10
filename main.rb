# Задача 22-5 — Виселица в github
#
require_relative 'lib/game'
require_relative 'lib/game_io_console'

game = Game.new
game_console = GameIOConsole.new(game)

game_console.greeting

loop do
  game_console.show_field
  letter = game_console.letter
  game.estimate(letter)
  break if game.finished?
end

game_console.show_result
