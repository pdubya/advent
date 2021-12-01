
target: Int64 = 2020
terms = 3
c = (1...terms).map { {} of Int64 => Int64 }
File.each_line("input1.txt")  do |x|
    q = x.to_i64
    if q.in? c.first.keys
        puts q*c.first[q]
        break
    end
    c[1..].each_with_index do |y, i|
        y.each { |k, v| c[i][k - q] = v*q unless q > k }
    end
    c.last[target - q] = q
end

