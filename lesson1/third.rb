triangle =[]
puts "Put first line"
triangle[0] = gets.chomp.to_f
puts "Put second line"
triangle[1] = gets.chomp.to_f
puts "Put third line"
triangle[2] = gets.chomp.to_f
triangle = triangle.sort.reverse
hypo = triangle.max

if triangle.uniq.size == 1
     puts "Треугольник равносторонний!"
elsif triangle.uniq.size == 2 
    puts "Треугольник равнобердренный!"
elsif (hypo * hypo) == (triangle[1]*triangle[1] + triangle[2] * triangle[2]) 
    puts "Треугольник прямоугольный!"
else 
    puts "Треугольник не имеет интересных особенностей..."
end
