require 'colorize'
require_relative 'game'

# IO console for Game Hangman
class GameIOConsole
  def initialize(game)
    @game = game
  end

  def description
    <<~TEXT
      Ваша задача - угадать слово, загаданное компьютером.
      В каждой попытке вы пробуете угадать одну букву.
      Если буква есть в слове, она открывается.
      Если нет - рисуется новый элементт виселицы.
      Успеете отгадать слово до того, как человечка повесят -
      Вы выиграли. Не успеете - выиграл компьютер.
    TEXT
  end

  def greeting
    puts '     * * * Игра Виселица * * *     '.black.on_red
    puts description.red.italic
  end

  def field
    file_path = File.join(File.dirname(__FILE__), '..', 'data', "#{@game.state}.txt")
    File.readlines(file_path, chomp: true)
  end

  def show_field
    print "\nЗагадано слово: ".cyan
    puts @game.word.to_s.light_blue.bold
    field.map { |s| puts s.yellow }
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
