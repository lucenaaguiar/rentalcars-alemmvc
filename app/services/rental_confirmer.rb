class RentalConfirmer
  def initialize(rental_id, car_id, addons_ids = [])
    @rental_id = rental_id
    @car_id = car_id
    @addons_ids = addons_ids
  end

  def confirm
    create_car
    rental.rental_items.create(rental_items_params)
    rental.rental_items.create(addon_items) if addons
    rental.update(price_projection: @rental.calculate_final_price)
  end

  private

  attr_reader :rental_id, :car_id, :addons_ids

  def rental_items_params
    {rentable: car,
    daily_rate: car.category.daily_rate +
                car.third_party_insurance +
                car.category.car_insurance
    }
  end

  def addon_items
    addons.map { |addon| addon.first_available_item }
    items = addon_items.each do |addon_item|
      {rentable: addon_item, daily_rate: addon_item.addon.daily_rate}
    end
    items
  end

  def rental
    @rental ||= Rental.find(rental_id)
  end

  def car
    @car ||= Car.find_by(id: car_id)
  end

  def addons
    @addons ||= Addon.where(id: addons_ids)
  end
end
