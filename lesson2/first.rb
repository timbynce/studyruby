require 'date'

calendar = (1..12).each_with_object({}) do |i, hash|
    month = Date::MONTHNAMES[i]
    days = Date.new(2022,i,-1).day
    hash[month] = days
    if days == 30 
        puts "#{month} have a #{30} days"
    end
end
