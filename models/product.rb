class Product
  attr_accessor :id, :name, :price, :amount

  def initialize(id, name, price, amount)
    @id     = id
    @name   = name
    @price  = price.to_f
    @amount = amount.to_i
  end

  def add
    @amount += 1
  end

  def sold
    @amount -= 1
  end

  def to_string
    " #{cell(@id, 2)} | #{cell(@name, 20)} | $#{cell(@price, 10)} | #{@amount}"
  end


  private

  def cell(data, size)
    data.to_s[0, size].ljust(size, ' ')
  end
end