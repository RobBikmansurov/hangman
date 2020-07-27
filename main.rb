# Задача 22-5 — Виселица в github
#
require_relative 'lib/game'

LETTERS = ('А'..'Я').map(&:to_s) << 'Ё'

puts '* * * Игра Виселица * * *'

game = Game.new('ЁЖИК') # ('СВОЙСТВО')
puts game.description

loop do
  puts
  puts "Загадано слово: #{game.word}"
  puts game.field
  puts "Вы вводили (#{game.errors.size} букв):  #{game.errors.join(', ')}" if game.errors.size.positive?
  print 'Введите букву: '

  until LETTERS.include?(letter = STDIN.gets.chomp.upcase)
    puts 'Нужно ввести русскую букву: '
  end
  game.estimate(letter)
  break if game.finished?
end

puts game.result
