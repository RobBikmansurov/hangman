require_relative 'game'

# IO console for Game Hangman
class GameIOConsole
  def initialize(game)
    @game = game
  end

  def greeting
    puts '* * * Игра Виселица * * *'
    puts @game.description
  end

  def show_field
    puts
    puts "Загадано слово: #{@game.word}"
    puts @game.field
    puts "Вы вводили (#{@game.errors.size} букв):  #{@game.errors.join(', ')}" if @game.errors.size.positive?
    print 'Введите букву: '
  end

  def letter
    until Game::LETTERS.include?(letter = STDIN.gets.chomp.upcase)
      puts 'Нужно ввести русскую букву: '
    end
    letter
  end

  def show_result
    puts @game.result
  end
end
