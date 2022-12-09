class Player
    @@number_of_players = 0 
    attr_accessor :name, :symbol
    def initialize
        puts "Please enter the name of the first player:"
        @name = gets.chomp
        puts "#{@name}, please enter the symbol you want to use:"
        @symbol = gets.chomp
        @@number_of_players += 1
    end

    def self.total_number_of_players
        @@number_of_players
    end
end

Player1 = Player.new()
puts "#{Player1.name}'s symbol is #{Player1.symbol}"
puts Player.total_number_of_players 