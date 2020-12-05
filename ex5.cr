
max_seat = -1
min_seat = 128*8 + 1
empty_seats = (0...128*8).to_set
File.each_line("input5.txt") do |x|
    a = 1 << 6
    row = 0
    (0..6).each do |i|
        row += a if x[i] == 'B'
        a >>= 1
    end

    b = 1 << 2
    col = 0
    (7..9).each do |i|
        col += b if x[i] == 'R'
        b >>= 1
    end
    seat = 8*row + col
    max_seat = Math.max(max_seat, seat)
    min_seat = Math.min(min_seat, seat)
    empty_seats -= Set{seat}
end
puts max_seat
puts min_seat
puts empty_seats
puts empty_seats.select { |u| u.in? min_seat..max_seat } 
