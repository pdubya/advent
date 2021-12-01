# executed = Set(Int64).new
# parser = /(nop|acc|jmp) (\+|-)(\d+)/
# offsets = [0.to_i64]
# acc = 0
# loc : Int64 = 0
# 
# def read_line(k, offsets, f)
#     puts "tape line: #{k}\tfile bytes: #{f.pos}"
#     if offsets[k + 1]?
#         f.seek(offsets[k])
#         return f.gets
#     else
#         res = ""
#         f.seek(offsets[-1])
#         (offsets.size..k+1).each do
#             res = f.gets
#             offsets << f.pos
#         end
#         return res
#     end
# end
# 
# File.open("input8.txt") do |f|
#     loop do
#         parser =~ read_line(loc, offsets, f)
#         executed << loc
# 
#         jump : Int64 = 1
#         case {$1, $2}
#         when {"acc", "+"}
#             acc += $3.to_i32
#         when {"acc", "-"}
#             acc -= $3.to_i32
#         when {"jmp", "+"}
#             jump = $3.to_i64
#         when {"jmp", "-"}
#             jump = -$3.to_i64
#         end
#         loc += jump
#         break if loc.in? executed
#     end
# end
# 
# puts loc
# puts acc
# 

parser = /(nop|acc|jmp) (\+|-)(\d+)/
arrive_at = Hash(Int32, Set(Int32)).new
loc = 0
File.each_line("input8.txt") do |x|
    parser =~ x

    jump : Int64 = 1
    case {$1, $2}
    when {"jmp", "+"}
        jump = $3.to_i64
    when {"jmp", "-"}
        jump = -$3.to_i64
    end
    (arrive_at[loc + jump] ||= Set(Int32).new) << loc
    loc += 1
end

puts loc
puts arrive_at[loc-1]
puts arrive_at[loc]
puts arrive_at.keys.max

terminal = arrive_at[loc]
new_terminal = Set(terminal.each { |x| 
while tsize < terminal.size
    tsize = terminal.size
    



