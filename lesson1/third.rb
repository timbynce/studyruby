triangle =[]
puts "Put first line"
triangle[0] = gets.chomp.to_f
puts "Put second line"
triangle[1] = gets.chomp.to_f
puts "Put third line"
triangle[2] = gets.chomp.to_f

triangle=triangle.sort.reverse
hypo=triangle.max

if triangle.uniq.size == 1 then puts "Триугольник равносторонний!"
elsif triangle.uniq.size == 2 then puts "Триугольник равнобердренный!"
elsif (hypo * hypo) == (triangle[1]*triangle[1] + triangle[2] * triangle[2]) then puts "Триугольник прямоугольный!"
else puts "Триугольник не имеет интересных особенностей..."
end

	