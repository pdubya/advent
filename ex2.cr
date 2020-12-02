
def rule1_valid?(p : String, c : Char, min_count : Int32, max_count : Int32)
    p.count(c).in? min_count..max_count
end

def rule2_valid?(p : String, c : Char, offset1 : Int32, offset2 : Int32)
    1 == [offset1, offset2].count { |q| p[q] == c }
end


count1 = 0
count2 = 0
parser = /(\d+)-(\d+) ([a-z]): ([a-z]+)/
File.each_line("input2.txt")  do |x|
    x =~ parser
    count1 += 1 if rule1_valid?($4, $3.char_at(0), $1.to_i, $2.to_i)
    count2 += 1 if rule2_valid?($4, $3.char_at(0), $1.to_i - 1, $2.to_i - 1)
end
puts "#{ count1 } rule1 valid passwords"
puts "#{ count2 } rule2 valid passwords"

