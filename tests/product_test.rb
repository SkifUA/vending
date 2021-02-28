require "test/unit"
require 'securerandom'
require_relative '../models/product'

class ProductTest < Test::Unit::TestCase
  def setup
    @id      = rand(100)
    @name    = SecureRandom.alphanumeric
    @price   = (rand * rand(10..50)).round(2)
    @amount  = rand(50)
    @product = Product.new(@id, @name, @price, @amount)
  end

  def test_init
    assert_equal @product.id,     @id
    assert_equal @product.name,   @name
    assert_equal @product.price,  @price
    assert_equal @product.amount, @amount
  end

  def test_add
    @product.add
    assert_equal @product.amount, @amount + 1
  end

  def test_sold
    @product.sold
    assert_equal @product.amount, @amount - 1
  end

  def test_to_string
    string = @product.to_string
    assert string.include?(@id.to_s),     'Include ID'
    assert string.include?(@name),        'Include Name'
    assert string.include?(@price.to_s),  'Include Price'
    assert string.include?(@amount.to_s), 'Include Amount'
  end
end