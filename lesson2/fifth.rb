require 'date'

def leap_year?(y)
  (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0)  
end

calendar = {1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31}
puts "Set year"
in_year = gets.chomp.to_i
puts "Set month"
in_month = gets.chomp.to_i
puts "Set day"
in_day = gets.chomp.to_i
num_day = 0

if leap_year?(in_year) == true
  calendar[2] = 29
end
if (calendar[in_month] < in_day)
  puts "Your date is wrong"
else
  (1..in_month).each do |i|
    if i == in_month
      num_day += in_day 
    else     
      num_day += calendar[i]
    end
end
  puts "Today is #{num_day}th day of the year"
end
