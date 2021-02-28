require "test/unit"
require_relative '../models/cashier'

class CashierTest < Test::Unit::TestCase
  def setup
    @c25    = rand(100)
    @c50    = rand(100)
    @c100   = rand(100)
    @c200   = rand(100)
    @c500   = rand(100)

    @cashier = Cashier.new(c25: @c25, c50: @c50, c100: @c100, c200: @c200, c500: @c500)
  end

  def test_init
    assert_equal @cashier.c25,  @c25
    assert_equal @cashier.c50,  @c50
    assert_equal @cashier.c100, @c100
    assert_equal @cashier.c200, @c200
    assert_equal @cashier.c500, @c500
  end

  def test_insert_one
    coin = [:c25, :c50, :c100, :c200, :c500].sample
    @cashier.insert(coin)
    assert_equal @cashier.send(coin), self.instance_variable_get("@#{coin}") + 1
  end

  def test_insert_several
    coin = [:c25, :c50, :c100, :c200, :c500].sample
    number = rand(100)
    @cashier.insert(coin, number)
    assert_equal @cashier.send(coin), self.instance_variable_get("@#{coin}") + number
  end

  def test_sum
    control_sum = @cashier.c25 * 0.25 + @cashier.c50 * 0.5 + @cashier.c100 * 1 + @cashier.c200 * 2 + @cashier.c500 * 5
    assert_equal @cashier.sum, control_sum
  end

  def test_extract_one
    coin = [:c25, :c50, :c100, :c200, :c500].sample
    @cashier.extract(coin)
    assert_equal @cashier.send(coin), self.instance_variable_get("@#{coin}") - 1
  end

  def test_extract_several
    coin = [:c25, :c50, :c100, :c200, :c500].sample
    number = rand(100)
    @cashier.extract(coin, number)
    assert_equal @cashier.send(coin), self.instance_variable_get("@#{coin}") - number
  end

  def test_reset
    @cashier.reset
    assert_equal @cashier.c25,  0
    assert_equal @cashier.c50,  0
    assert_equal @cashier.c100, 0
    assert_equal @cashier.c200, 0
    assert_equal @cashier.c500, 0
  end
end