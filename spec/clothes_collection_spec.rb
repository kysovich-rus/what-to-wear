require 'clothes_collection'

RSpec.describe 'ClothesCollection' do
  let(:collection) do
    ClothesCollection.new(
      [
        Clothing.new(name: 'Футболка', type: 'Торс', min_temp: 15, max_temp: 35),
        Clothing.new(name: 'Штаны зимние', type: 'Низ', min_temp: -25, max_temp: -5),
        Clothing.new(name: 'Кроссовки', type: 'Обувь', min_temp: 5, max_temp: 25)
      ]
    )
  end

  describe '#initialize' do
    it 'assigns array of class Clothing instances to collection' do
      expect(collection.items).to be_a Array
      expect(collection.items.count).to eq 3
      expect(collection.items.sample).to be_a Clothing
    end
  end

  describe '#clothes_types' do
    it 'returns types array' do
      expect(collection.clothes_types).to match_array %w[Торс Низ Обувь]
    end
  end

  describe '#clothes_of_type' do
    let(:chosen_type) { collection.clothes_types.sample }

    it 'returns array of clothes of same type (random pick test)' do
      expect(collection.clothes_of_type(chosen_type)).to be_a Array
      expect(collection.clothes_of_type(chosen_type).sample.type).to eq chosen_type
    end

    it 'returns clothes of chosen type' do
      type = 'Низ'
      expect(collection.clothes_of_type(type)).to match_array [collection.items[1]]
    end
  end

  describe '#pick_suggestions' do
    context 'when suitable clothes exist for chosen temperature' do
      it 'returns array of clothes of each type' do
        temp = 20

        # Вернет футболку и Кроссовки
        expect(collection.pick_suggestions(temp)).to be_a Array
        expect(collection.pick_suggestions(temp)).to match_array [collection.items[0], collection.items[2]]
      end
    end

    context 'when no suitable clothes exist' do
      it 'returns empty array' do
        temp = 451
        expect(collection.pick_suggestions(temp)).to be_a Array
        expect(collection.pick_suggestions(temp)).to match_array []
      end
    end
  end

  describe '.read_from_dir' do
    let(:path) { "#{File.dirname(__FILE__)}/fixtures" }
    let(:expected) do
      {
        name: ['Футболка', 'Штаны зимние', 'Кроссовки'],
        type: %w[Торс Низ Обувь],
        min_temp: [15, -25, 5],
        max_temp: [35, -5, 25]
      }
    end

    it 'creates Clothing instances for every read .txt file' do
      # ожидаем, что прочитанная из файлов коллекция будет такой же, как и заданная в тестах выше
      expect(ClothesCollection.read_from_dir(path).sample).to be_a Clothing
      expect(ClothesCollection.read_from_dir(path).count).to eq 3
    end

    it 'creates Clothing instances with expected variables' do
      expect(ClothesCollection.read_from_dir(path).map(&:name)).to match_array expected[:name]
      expect(ClothesCollection.read_from_dir(path).map(&:type)).to match_array expected[:type]
      expect(ClothesCollection.read_from_dir(path).map(&:min_temp)).to match_array expected[:min_temp]
      expect(ClothesCollection.read_from_dir(path).map(&:max_temp)).to match_array expected[:max_temp]
    end
  end
end
