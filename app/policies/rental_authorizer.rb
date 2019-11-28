class RentalAuthorizer
  def initialize(rental, user)
    @rental = rental
    @user = user
  end

  def authorized?
   admin? || employee?
  end

  private

  def admin?
    user.admin?
  end

  def employee?
    user.subsidiary.eql? user.subsidiary
  end

  attr_reader :rental, :user
end
