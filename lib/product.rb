class Product
  attr_accessor :name
  attr_accessor :type
  attr_accessor :price

  def initialize(name: name, type: type, price: price)
    @name = name
    @type = type
    @price = price
  end
end
