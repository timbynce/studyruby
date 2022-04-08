require 'date'

def leap_year?(y)
    (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0)  
  end

puts "Set year"
year = gets.chomp
puts "Set month"
month = gets.chomp
puts "Set day"
day = gets.chomp
first_date= Date.parse(year+"-1-1")
last_date = Date.parse(year+"-"+month+"-"+day)
days_gone = (last_date - first_date).to_i
#понимаю, что существует контраст между "прошло х дней" и "сегодня наступит х+1" день. В кода показалось более красивым.
puts "Just #{days_gone} days gone in this year"
