require 'colorize'


class Game
  attr_accessor :secret_combination
  
  def initialize(player)
    @secret_combination = player.player_combination
    @player = player
    @player.game = self
    puts "Starting Game"
  end 
end

class Player
  attr_accessor :game, :player_guess, :combination, :player_combination
  
  def initialize
    @counter = 12
    @player_combination = [rand(1..4).to_s, rand(1..4).to_s, rand(1..4).to_s, rand(1..4).to_s].shuffle

  end 

  def guess
    @player_guess = []
    correct_array = []
    combination = []
    @game.secret_combination.each { |value| combination << value}
    counter = 0
    combination.each do |number|
      print("Insert your guess: ")
      actual_guess = gets.chomp
      if @player_guess.include?(actual_guess)
        @player_guess[@player_guess.index(actual_guess)] = @player_guess[actual_guess.to_i]
      end
      @player_guess << actual_guess
      puts
      if combination.include?(actual_guess)
        if @player_guess.index(actual_guess) == combination.index(actual_guess)
          correct_array << "C".green
          combination[combination.index(actual_guess)] = @player_guess[actual_guess.to_i].to_i
          counter += 1
        else
          correct_array << "WC".yellow
          combination[combination.index(actual_guess)] = @player_guess[actual_guess.to_i].to_i
          counter += 1
        end
      else
        correct_array << "W".red
        combination[counter] = combination[counter].to_i
        counter += 1
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

class Computer < Player
  attr_reader :player_combination
  
  def initialize(array)
    @counter = 12
    @player_combination = array
  end 

  def guess
    sleep(1)
    @player_guess = []
    correct_array = []
    combination = []
    @game.secret_combination.each { |value| combination << value}
    counter = 0
    combination.each do |number|
      print("Insert your guess: ")
      actual_guess = rand(1..4).to_s
      print actual_guess
      puts
      
      if @player_guess.include?(actual_guess)
        @player_guess[@player_guess.index(actual_guess)] = @player_guess[actual_guess.to_i]
      end
      @player_guess << actual_guess
      puts
      if combination.include?(actual_guess)
        if @player_guess.index(actual_guess) == combination.index(actual_guess)
          correct_array << "C".green
          combination[combination.index(actual_guess)] = @player_guess[actual_guess.to_i].to_i
          counter += 1
        else
          correct_array << "WC".yellow
          combination[combination.index(actual_guess)] = @player_guess[actual_guess.to_i].to_i
          counter += 1
        end
      else
        correct_array << "W".red
        combination[counter] = combination[counter].to_i
        counter += 1
      end
    end
    puts correct_array.shuffle!
    win_checker(correct_array)
  end
end


def start_game
  i = false
  while i == false
    puts "[1] to play as a guesser" 
    print "[2] to be the creator of the secret code: "
    type = gets.chomp.to_i
    if type == 1
      puts
      player = Player.new
      game = Game.new(player)
      i = true
    elsif type == 2
      puts
      code_array = []
      counter = 1
      
      while counter < 5
        puts "Insert the secret code (4 Numbers from 1 to 4) :"
        number = gets.chomp
        if number == "1" || number == "2" || number == "3" || number == "4"
          code_array << number
          p code_array
          counter += 1
        else
          puts "Invalid Number".red
        end   
      end
      player = Computer.new(code_array)
      game = Game.new(player)
      i = true
    else
      puts "There's no such option, insert again".red
    end 
  end
    puts game.secret_combination
    puts player.guess

end

start_game
