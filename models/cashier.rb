class Cashier
  attr_reader :c25, :c50, :c100, :c200, :c500

  def initialize(c25: 0, c50: 0, c100: 0, c200: 0, c500: 0)
    @c25    = c25
    @c50    = c50
    @c100   = c100
    @c200   = c200
    @c500   = c500 
  end

  def insert(coin, number = 1)
    instance_variable_set("@#{coin}", instance_variable_get("@#{coin}") + number.to_i)
  end

  def sum
    instance_variables.inject(0){ |s, n| s + (coin_value(n) * instance_variable_get(n)) }
  end

  def extract(coin, number = 1)
    instance_variable_set("@#{coin}", instance_variable_get("@#{coin}") - number.to_i)
  end

  def report
    instance_variables.map { |name| [name.to_s.sub('@','').to_sym, instance_variable_get(name)] }.to_h
  end

  def reset
    instance_variables.each do |attr|
      instance_variable_set(attr, 0)
    end
  end


  private

  def coin_value(coin)
    coin.to_s.sub(/^\D+/, '').to_i / 100.0
  end
end