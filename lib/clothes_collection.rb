require_relative 'clothing'

class ClothesCollection
  attr_accessor :items

  def self.read_from_dir(dir_path)
    Dir["#{dir_path}/*.txt"].map do |path|
      lines = File.readlines(path, encoding: 'UTF-8', chomp: true)
      temp_range = lines[2].scan(/[+-]?\d+/)
      Clothing.new(
        name: lines[0],
        type: lines[1],
        min_temp: temp_range[0].to_i,
        max_temp: temp_range[1].to_i
      )
    end
  end

  def initialize(items = [])
    @items = items
  end

  def clothes_types
    @items.map(&:type).uniq
  end

  def clothes_of_type(current_type)
    @items.select { |item| item.type == current_type }
  end

  def pick_suggestions(temp)
    clothes_types.filter_map do |type|
      clothing = clothes_of_type(type).select { |item| item.suitable?(temp) }.sample
      clothing unless clothing.nil?
    end
  end
end
