
def valid_data?(v : String, k : String)
    year_ranges = {"byr" => 1920..2002, "iyr" => 2010..2020, "eyr" => 2020..2030}
    height_ranges = {"cm" => 150..193, "in" => 59..76}

    case {k, v}
    when {.in?(%w(byr iyr eyr)), /^(\d{4})$/}
        $~[1].to_i.in? year_ranges[k]
    when {"hgt", /^(\d+)(cm|in)$/}
        $~[1].to_i.in? height_ranges[$~[2]]
    when {"hcl", /^#[0-9a-f]{6}$/}
        true
    when {"ecl", .in?(%w(amb blu brn gry grn hzl oth))}
        true
    when {"pid", /^\d{9}$/}
        true
    else
        false
    end
end

valid = 0
required = %w(byr iyr eyr hgt hcl ecl pid cid).to_set - Set{"cid"}
test = required
File.each_line("input4.txt")  do |x|
    if x.strip.blank?
        valid += 1 if test.empty?
        test = required
        next
    end
    x.split.each do |kv|
        k, v = kv.split(":")
        test -= Set{k} if valid_data?(v, k)
    end
end
valid += 1 if test.empty?
puts valid


