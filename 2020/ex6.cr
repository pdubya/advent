
group_answers : Set(Char) | ::Nil = nil
total_answers = 0
File.each_line("input6.txt") do |x|
    if x.strip.blank?
        total_answers += group_answers ? group_answers.size : 0
        group_answers = nil
        next
    end
    v = Set.new(x.chars)
    group_answers ||= v
    group_answers &= v
end
total_answers += group_answers ? group_answers.size : 0
puts(total_answers)

