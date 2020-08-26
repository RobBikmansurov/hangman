require 'colorize'
require_relative 'game'

# IO console for Game Hangman
class GameIOConsole
  def initialize(game)
    @game = game
  end

  def greeting
    puts '     * * * Игра Виселица * * *     '.black.on_red
    puts @game.description.red.italic
  end

  def show_field
    print "\nЗагадано слово: ".cyan
    puts "#{@game.word}".light_blue.bold
    @game.field.map { |s| puts s.yellow }
    puts "Вы вводили #{@game.letters_declension}: #{@game.errors.join(', ')}".red if @game.errors.size.positive?
    print 'Введите букву: '.cyan
  end

  def letter
    until Game::LETTERS.include?(letter = STDIN.gets.chomp.upcase)
      puts 'Нужно ввести русскую букву: '.red
    end
    letter
  end

  def show_result
    puts @game.result.light_red
  end
end
