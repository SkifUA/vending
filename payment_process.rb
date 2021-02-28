def payment_process(price)
  puts 'Please insert one coin at a time. To cancel input `#`'

  inputed_cash = Cashier.new
  paid = false
  aliases = {
    '25c' => :c25,
    '50c' => :c50,
    '1$'  => :c100,
    '2$'  => :c200,
    '5$'  => :c500 
  }

  loop do 
    input = gets.chomp

    if input == '#'
      puts "Coins was returned: $#{inputed_cash.sum}"
      inputed_cash.reset
      break
    elsif (coin = aliases[input])
      inputed_cash.insert(coin)
      sum = inputed_cash.sum
      if sum >= price
        change, left = $storage_cash.prepare_change(sum - price)

        if left != 0 && yes_no?("Unfortunately there are not enough coins for change: $#{left}. Return the money?") 
          puts "Coins was returned: $#{inputed_cash.sum}"
          inputed_cash.reset
          break
        end
        $storage_cash.withdraw(change)
        puts "Change was returned: $#{change.sum}"
        paid = true
        break 
      else
        puts "Inserted $#{sum}, left: $#{price - sum}"
      end
    else
      puts "Coin musr be only one, include #{aliases.keys}"
    end
  end
  [paid, inputed_cash]
end