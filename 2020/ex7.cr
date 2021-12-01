
class BagRule

    @@known_rules = Hash(String, BagRule).new
    @@parents = Hash(BagRule, Set(BagRule)).new

    def self.parents
        @@parents
    end

    def self.find(nm : String)
        @@known_rules[nm] ||= BagRule.new(nm)
    end

    getter name : String
    @nested_bags : Int32?

    def initialize(@name : String)
        @nested_bags = nil
        @requirements = {} of BagRule =>  Int32
        @@parents[self] = Set(BagRule).new
    end

    def add_requirement(bag : BagRule, count : Int32)
        @requirements[bag] = count 
        @@parents[bag] << self
    end

    def find_ancestors(including = Set(BagRule).new)
        next_parents = @@parents[self] - including
        including.concat @@parents[self]
        next_parents.each { |b| including.concat b.find_ancestors(including) }
        including
    end

    def invalid_dependencies(known_invalid = Set(BagRule).new)
        next_deps = @nested_bags.nil? ? @requirements.keys.to_set - known_invalid : Set(BagRule).new
        known_invalid.concat next_deps
        next_deps.each { |b| known_invalid.concat b.invalid_dependencies(known_invalid) }
        known_invalid
    end

    def intersects?(invalid_deps : Set(BagRule))
        unless res = @requirements.keys.any? &.in?(invalid_deps)
            @nested_bags = @requirements.sum(0) { |b, w| w*(1 + b.nested_bags.as(Int32)) }
        end
        res
    end

    private def touch_nested_bags
        all_deps = invalid_dependencies << self
        puts(all_deps.size)
        until all_deps.empty?
            all_deps.each do |b|
                unless b.intersects? all_deps
                    all_deps.delete b
                end
            end
            puts(all_deps.size)
        end
        @nested_bags
    end

    def nested_bags
        @nested_bags || touch_nested_bags
    end

end

parser = /^(\w+ \w+) bags contain (?:no other bags)*(.*)\.$/
splitter = /(\d+) (\w+ \w+)/
File.each_line("input7.txt") do |x|
    parser =~ x
    outer_bag = BagRule.find $1
    $2?.to_s.scan(splitter) do |m|
        inner_bag = BagRule.find m[2].as(String)
        outer_bag.add_requirement inner_bag, m[1].to_i32
    end
end

sg = BagRule.find "shiny gold"
a = sg.find_ancestors
puts(a.map &.name)
puts(a.size)
puts(sg.nested_bags)
mt = BagRule.find "muted tan"
puts(mt.nested_bags)


