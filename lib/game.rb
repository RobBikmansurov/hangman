require_relative 'sklonator'

# Game Hangman
class Game
  LETTERS = ('А'..'Я').map(&:to_s) << 'Ё'

  attr_reader :attempts

  def initialize(word)
    @word = word.upcase
    @attempts = 0
    @state = 0
    @wrong_letters = []
    @correct_letters = []
    @correct_letters << @word[0]
    @correct_letters << @word[-1]
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

  def finished?
    @state > 5 || guessed?
  end

  def guessed?
    (word.chars - @correct_letters).size.zero? || (normalized(word).chars - @correct_letters).size.zero?
  end

  def errors
    @wrong_letters
  end

  def estimate(letter)
    @attempts += 1
    normalized_letter = normalized(letter)
    return if normalized(@wrong_letters.join).include?(normalized_letter)

    normalized_word = normalized(@word)
    if normalized_word.chars.include?(normalized_letter)
      @correct_letters << normalized_letter unless @correct_letters.include?(normalized_letter)
    else
      @wrong_letters << letter
      @state += 1
    end
  end

  def result
    return "\nВы угадали слово #{@word} за #{attempts_declension} и заслуженно победили!" if guessed?

    result = field
    result << "\nВы пробовали (#{letters_declension}): #{@wrong_letters.join(', ')}" if @wrong_letters.size.positive?
    result << "\nВы проиграли! Было загадано слово #{@word}"
  end

  def word
    @word.chars.map do |letter|
      if @correct_letters.include?(letter) || @correct_letters.include?(normalized(letter))
        letter.upcase
      else
        '-'
      end
    end.join
  end

  def field
    file_path = File.join(File.dirname(__FILE__), '..', 'data', "#{@state}.txt")
    File.readlines(file_path, chomp: true)
  end

  def letters_declension
    Sklonator.num_to_str(@wrong_letters.size, 'букву', 'буквы', 'букв', true)
  end

  private

  def attempts_declension
    Sklonator.num_to_str(@attempts, 'попытка', 'попытки', 'попыток', true)
  end

  def normalized(letter)
    letter.tr('ЁЙ', 'ЕИ')
  end
end
