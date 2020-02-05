class Contract
  attr_accessor :signed_on
  attr_accessor :product

  def initialize(signed_on:, product:)
    @signed_on = signed_on
    @product = product
  end

  def revenue_on(date)
    return 0 if date < @signed_on
    if type == 'W'
      price
    elsif type == 'S'
      return price if signed_on_past?(date, threshold: 30)
      (price * Rational(2, 3)).to_i
    elsif type == 'D'
      return price if signed_on_past?(date, threshold: 120)
      return price / 3 * 2 if signed_on_past?(date, threshold: 60)
      price / 3
    end
  end

  private

  def type
    @product.type
  end

  def price
    @product.price
  end

  def signed_on_past?(date, threshold: 0)
    date >= @signed_on + threshold
  end
end
