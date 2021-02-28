require "test/unit"
require_relative '../models/mashin_cashier'

class MashinCashierTest < Test::Unit::TestCase
  def setup
    @c25    = rand(1..10)
    @c50    = rand(1..10)
    @c100   = rand(1..10)
    @c200   = rand(1..10)
    @c500   = rand(1..10)
    
    @mashin_cashier = MashinCashier.new(c25: @c25, c50: @c50, c100: @c100, c200: @c200, c500: @c500)
  end

  def test_merge
    cashier = Cashier.new(c25: @c25 - 1, c50: @c50 - 1, c100: @c100 - 1, c200: @c200 - 1, c500: @c500 - 1)
    @mashin_cashier.merge(cashier)

    assert_equal @mashin_cashier.c25,  (@c25 * 2) - 1
    assert_equal @mashin_cashier.c50,  (@c50 * 2) - 1
    assert_equal @mashin_cashier.c100, (@c100 * 2) - 1
    assert_equal @mashin_cashier.c200, (@c200 * 2) - 1
    assert_equal @mashin_cashier.c500, (@c500 * 2) - 1
  end

  def test_withdraw
    cashier = Cashier.new(c25: 1, c50: 1, c100: 1, c200: 1, c500: 1)
    @mashin_cashier.withdraw(cashier)

    assert_equal @mashin_cashier.c25,  @c25 - 1
    assert_equal @mashin_cashier.c50,  @c50 - 1
    assert_equal @mashin_cashier.c100, @c100 - 1
    assert_equal @mashin_cashier.c200, @c200 - 1
    assert_equal @mashin_cashier.c500, @c500 - 1
  end

  def test_prepare_change
    number_of_change = rand(1..10) + [0.25, 0.5, 0.75].sample
    change, left = @mashin_cashier.prepare_change(number_of_change)

    assert change.sum + left == number_of_change, 'Number of change same'
  end
end