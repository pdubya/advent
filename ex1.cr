
c = [] of Int64
File.each_line("input1.txt")  { |x| c << x.to_i64 }

target = 2020
done = false

until c.empty?
    r = c.shift
    d = c.clone
    until d.empty?
        v = d.min
        u = target - v - r
        if u.in? d
            puts v*u*r
            done = true
            break
        end
        d.select! { |x| x > v & x < u }
        puts "\t#{ d.size }"
    end
    break if done
    puts "next iter"
end

