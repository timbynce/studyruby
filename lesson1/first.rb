puts "What is your name?"
name = gets.chomp
puts "Tell me your height (cm)"
height = gets.chomp.to_f
optimal_weight= (height - 110) * 1.15

optimal_weight.positive? ? (puts "#{name}, your optimal weight is #{optimal_weight} kg") : (puts "You alreday good!")
