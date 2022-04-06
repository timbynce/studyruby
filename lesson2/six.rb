purchases={}
name = nil
sum = 0
until name == "Стоп"
    puts "Введите название товара"
    name = gets.chomp
    if name != "Стоп"
        puts "Введите его цену"
        price = gets.chomp.to_f
        puts "Какое число #{name} вы купили?"
        quantity = gets.chomp.to_i
        sum_position = (price * quantity)
        purchases[name] = {price: price, quantity: quantity, sum_position: sum_position }        
    end
end

total = "%0.2f" % (purchases.each_value.reduce(0) { |k,v| k + v[:sum_position]})
puts "Сумма покупок: #{total}"
puts purchases
