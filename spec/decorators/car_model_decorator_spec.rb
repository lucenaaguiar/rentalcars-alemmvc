require 'rails_helper'

describe CarModelDecorator do
  describe "#photo" do
    it 'should render image if attached' do
      car_model = build(:car_model)
      car_model.photo.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', '150X150.png')),
        filename: '150x150.png'
      )

      expect(car_model.decorate.photo).to be_attached
    end

    it 'should render image if not present' do
      car_model = build(:car_model)

      expect(car_model.decorate.photo).to eq 'https://via.placeholder.com/150x150'
    end
  end

  describe "#car_options" do
    it 'should return array of car options' do
      car_model = build(:car_model, car_options: 'Quatro Portas,Ar')
      #car_model = build(:car_model, car_options: 'Quatro Portas,Ar').decorate

      expect(car_model.decorate.car_options).to include('Quatro Portas')
      expect(car_model.decorate.car_options).to include('Ar')
      expect(car_model.decorate.car_options.count).to eq(2)
    end

    it 'should return empty array' do
      car_model = build(:car_model, car_options: nil)

      expect(car_model.car_options).to be_nil
    end
  end
end
