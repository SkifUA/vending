require_relative 'payment_process'
require_relative 'tools'
require_relative 'models/product'
require_relative 'models/cashier'
require_relative 'models/mashin_cashier'

$product_list = []
$storage_cash = MashinCashier.new

File.readlines('./storage/products.txt').each do |row|
  params = row.split(',').map(&:strip)
  $product_list << Product.new(params[0], params[1], params[2], params[3])
end

File.readlines('./storage/cash.txt').each do |row|
  params = row.split(',').map(&:strip)
  $storage_cash.insert(params[0], params[1])
end

print_product_list

loop do
  puts 'Pleace input choose number or `#` for cancel'
  
  input =  gets.chomp
  if input == '#'
    break
  elsif input == 'list'
    print_product_list
  else
    choice = $product_list.detect { |p| p.id == input }

    if choice.nil?
      puts "You should choose only from: #{$product_list.map(&:id)}"
      next
    end

    if choice.amount == 0
      puts "Sorry the goods are out of stock"
      next
    end

    success, cash = payment_process(choice.price)
    if success
      choice.sold
      $storage_cash.merge(cash)
      print_product_list
    else
      next
    end
  end
end
