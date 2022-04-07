def fibonacci(n)
  arr = []
  before = 0
  after = 1
  while before < n do
    arr.push(before)
    after, before = before, after + before
  end
  return arr
end

arr_fib = fibonacci(100)
puts arr_fib
