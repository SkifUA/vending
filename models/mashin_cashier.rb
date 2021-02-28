require './models/cashier'

class MashinCashier < Cashier

  def merge(cash_object)
    current_numbers = report
    cash_object.report.each do |key, value|
      next if value == 0
      insert(key, value)
    end
  end

  def withdraw(cash_object)
    current_numbers = report
    cash_object.report.each do |key, value|
      next if value == 0
      extract(key, value)
    end
  end

  def prepare_change(number)
    change = Cashier.new
    left   = number
    instance_variables.map { |name| [name.to_s.sub('@','').to_sym, coin_value(name)] }
      .select { |k, v| v < left && send(k) != 0 }
      .sort_by { |_k, v| v }
      .reverse
      .each do |name, val|
        break if left == 0.0
        number_of_coin = [(left / val).to_i, send(name)].min
        change.insert(name, number_of_coin)
        left = left - (number_of_coin * val)
      end
    [change, left]
  end
end