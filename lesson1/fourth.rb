puts "Put a"
a = gets.chomp.to_f
puts "Put b"
b = gets.chomp.to_f
puts "Put c"
c = gets.chomp.to_f

d = b*b - 4*a*c

if (d>0) 

	x1=(b*(-1) + Math.sqrt(d))/(2*a)
	x2=(b*(-1) - Math.sqrt(d))/(2*a)
	puts "Дискриминант : #{d}, корень х1: #{x1} , корень х2: #{x2}"
elsif (d==0)
	x1=(b*(-1) + Math.sqrt(d))/(2*a)
	x2=(b*(-1) - Math.sqrt(d))/(2*a)
	puts "Дискриминант : #{d}, корень х1: #{x1} , корень х2: #{x2}"
else	
	puts "Корней нет!"
end