require 'rails_helper'

describe RentalAuthorizer do
  context '#authorized?' do
    xit 'should be true if admin' do
      user = create(:user, :role, :admin)
      rental = create(:rental)

      expect(described_class.new(rental, user)).to be_authorized
    end

    xit 'should be true if employee' do
      user = create(:user, :role, :employee)
      rental = create(:rental)

      expect(described_class.new(rental, user)).to be_authorized
    end

    xit 'should be false' do
      user = create(:user, :role, :user)
      rental = create(:rental)

      expect(described_class.new(rental, user)).to be_not_authorized
    end
  end
end
