
def print_product_list
  puts 'Num |         Name         |    Price    | Amount'
  $product_list.each do |product|
    puts product.to_string
  end
end

def yes_no?(text)
  agree = false
  loop do
    puts text
    puts 'Y - yes'
    puts 'N - no'
    input =  gets.chomp
    if ['#', 'n', 'N'].include? input
      break
    elsif ['y', 'Y'].include? input
      agree = true
      break
    end
  end
  agree
end