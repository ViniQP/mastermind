require 'colorize'


class Game
  attr_reader :secret_combination
  
  def initialize(player)
    @secret_combination = ["1", "2", "3", "4"].shuffle   
    @player = player
    @player.game = self
    
  end 
end

class Player
  attr_accessor :game, :player_guess
  
  def initialize
    @counter = 12
  end 

  def guess
    @player_guess = []
    correct_array = []
    @game.secret_combination.each do |number|
      print("Insert your guess: ")
      actual_guess = gets.chomp
      if @player_guess.include?(actual_guess)
        @player_guess[@player_guess.index(actual_guess)] = @player_guess[actual_guess.to_i]
      end
      @player_guess << actual_guess
      puts
      if @game.secret_combination.include?(actual_guess)
        if @player_guess.index(actual_guess) == @game.secret_combination.index(actual_guess)
          correct_array << "C".green
        else
          correct_array << "WC".yellow
        end
      else
        correct_array << "W".red
      end
    end
    puts correct_array.shuffle!
    win_checker(correct_array)
  end

  def win_checker(correct_array)
    
    if correct_array.all? { |guess| guess == "C".green}
      puts "You WON!"
    elsif @counter > 1
      puts "TRY AGAIN!"
      @counter -= 1
      puts "You have #{@counter} chances left"
      self.guess
    else
      puts "YOU LOSE!"
    end
  end
end 

player = Player.new
a = Game.new(player)

puts a.secret_combination
puts player.guess
