require_relative 'lib/clothes_collection'
require_relative 'lib/clothing'

collection = ClothesCollection.new
collection.items = ClothesCollection.read_from_dir("#{File.dirname(__FILE__)}/data")

print 'Введите температуру: '
temp = $stdin.gets.to_i

puts 'Предложение на сегодня:'
suggestions = collection.pick_suggestions(temp)

puts suggestions.empty? ? 'Нет вещей под текущую погоду!' : suggestions
