#require 'pry-byebug'

$turns = 0
$rough_length = 3
$total_turns = $rough_length*$rough_length
$rough_array = Array.new($rough_length) { Array.new($rough_length) }

class Player 
  @@number_of_players = 0

  attr_accessor :name, :symbol

  def initialize
    puts 'Please enter the name of the first player:'
    @name = gets.chomp
    puts "#{@name}, please enter the symbol you want to use:"
    @symbol = gets.chomp
    @@number_of_players += 1
  end

  def self.total_number_of_players
    @@number_of_players
  end

  def choose_the_position
    puts 'Please choose the position you want to play'
    gets.chomp.to_i
  end
end


def show_game()
  $rough_array.each do |row|
    row.each do |val|
      print val
    end
    puts
  end
end

def check_row()
  $rough_array.each do |row|
    if row.all?(row.first)
      return true
    end
  end
  false
end

def check_column()
  $rough_array.each_index do |ind|
    column = []
    for i in 0..($rough_length-1)
      column.push($rough_array[i][ind])
    end
    if column.all?(column.first)
      return true
    end
  end
  false
end

def check_diagonal()
  # check left/main diagonal
  diagonal_matched = true
  first_element_of_left_diagonal = $rough_array.first.first
  for i in 0..($rough_length-1)
    if $rough_array[i][i] != first_element_of_left_diagonal
      diagonal_matched = false
      break
    end
  end

  return true if diagonal_matched
  # check right diagonal
  return false if $rough_array.first.last != $rough_array.last.first

  for i in 1..($rough_length-2)
    return false if $rough_array[i][i] != $rough_array.first.last
  end
  return true
end

def check_if_game_won()
  check_row() or check_column() or check_diagonal()
end

def print_result(winner, drawn) 
  if drawn
    puts "Game was drawn!"
  else
    puts "#{winner} has won!"
  end
end

Player1 = Player.new
puts "#{Player1.name}'s symbol is #{Player1.symbol}"

Player2 = Player.new
puts "#{Player2.name}'s symbol is #{Player2.symbol}"

player_to_play = true
game_can_continue = true

k = 1
$rough_array.each do |row|
  row.each_index do |column_index|
    row[column_index] = k
    k += 1
  end
end

show_game

while game_can_continue
  if(player_to_play)
    current_player = Player1
    choice = Player1.choose_the_position
    player_to_play = false
    row_position = (choice % $rough_length).zero? ? (choice/$rough_length)-1 : (choice/$rough_length).floor
    column_position = (choice % $rough_length).zero? ? $rough_length - 1 : choice % $rough_length - 1
    #binding.pry
    $rough_array[row_position][column_position] = Player1.symbol
    #binding.pry
  else
    current_player = Player2
    choice = Player2.choose_the_position
    player_to_play = true
    row_position = (choice % $rough_length).zero? ? (choice/$rough_length)-1 : (choice/$rough_length).floor
    column_position = (choice % $rough_length).zero? ? ($rough_length - 1) : (choice % $rough_length) - 1
    $rough_array[row_position][column_position] = Player2.symbol
  end
  $turns += 1
  show_game()
  if $turns==$total_turns
    game_can_continue = false
    if check_if_game_won()
      winner = current_player.name
    else
      drawn = true
    end
    print_result(winner, drawn)
  elsif check_if_game_won
    game_can_continue = false
    winner = current_player.name
    drawn = false
    print_result(winner, drawn)
  end

end