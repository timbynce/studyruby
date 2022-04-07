def fibonacci(n)
  arr =[]
  before = 0
  after = 1
  while before < n do
      arr.push(before)
      after,before = before, after + before
  end
  return arr
end

puts fibonacci(100)
