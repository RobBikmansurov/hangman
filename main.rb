# Игра Виселица в github

require_relative 'lib/game'
require_relative 'lib/game_io_console'

file_path = File.join(File.dirname(__FILE__), 'data', 'words.txt')
begin
  word = File.readlines(file_path, chomp: true).sample
rescue Errno::ENOENT => e
  puts e.message
  puts 'Ошибка чтения файла со словами!'
  exit(2)
end

game = Game.new(word)
game_console = GameIOConsole.new(game)

game_console.greeting

loop do
  game_console.show_field
  letter = game_console.letter
  game.estimate(letter)
  break if game.finished?
end

game_console.show_result
