
require "big"

strides = [BigRational.new(1), BigRational.new(3), BigRational.new(5), BigRational.new(7), BigRational.new(1, 2)]
trees = [0.to_i64]*strides.size
offsets = [BigRational.new(0)]*strides.size
File.each_line("input3.txt")  do |x|
    strides.each_with_index do |s, i|
        if offsets[i].denominator == 1
            q = offsets[i].numerator.to_i % x.size
            trees[i] += 1 if x[q] == '#'
        end
        offsets[i] += s
    end
end

puts trees
puts trees.product

