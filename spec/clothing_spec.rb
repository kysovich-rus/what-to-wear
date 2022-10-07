require 'clothing'

RSpec.describe 'Clothing' do
  let(:cloth) { Clothing.new(name: 'Футболка', type: 'Торс', min_temp: 18, max_temp: 40) }
  describe '#initialize' do
    it 'correct assigns instance variables' do
      expect(cloth.name).to eq 'Футболка'
      expect(cloth.type).to eq 'Торс'
      expect(cloth.min_temp).to eq 18
      expect(cloth.max_temp).to eq 40
    end
  end

  describe '#suitable?' do
    context 'when temperature is in range' do
      let(:temp) { rand(cloth.min_temp..cloth.max_temp) }

      it 'returns true' do
        expect(cloth.suitable?(temp)).to be true
      end
    end

    context 'when temperature is out of range' do
      let(:temp) { rand(2).zero? ? rand(-273...cloth.min_temp) : rand((cloth.max_temp + 1)..1000) }

      it 'returns false' do
        expect(cloth.suitable?(temp)).to be false
      end
    end
  end

  describe '#to_s' do
    it 'returns correct string' do
      expect(cloth.to_s).to eq 'Торс: Футболка (18..40)'
    end
  end
end
