require 'json'
  


class Hangman
  attr_accessor :letters_left, :gallow_count, :current_word, :current_word_hidden
  
  def initialize
    @@letters_left = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
    @@gallow_count = 0
    @@current_word_hidden = String.new
  end

###This is the opening sequence for each game###
  def open_sequence
    display =  "   --------^ \n   |       | \n   O       | \n  /|\\      |\n  / \\      | \n           | \n __________|__"
    puts display
    puts "Welcome to Hangman!!! \nThe goal of the game here is to guess the secret word one letter at a time.\nEach mistake brings you closer to hanging our poor friend Disonoris Kagelbon. \nAt any time in your game you can type 'SAVE' to save your game for later. \nBegin by typing 'new', or open an existing game with 'open' " 
    decision = gets.chomp
    if decision == "new"
      new_game
      game_play
    elsif decision == "open"
      open_saved
      game_play
    end
  end
  
###This resets the variables for a new game and assigns a new word to play with###
  def new_game
    @@current_word = game_word.upcase!
    (@@current_word.length - 1).times do 
      @@current_word_hidden << "-"
    end 
    @@gallow_count = 0
    @letters_left = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
  end
  
### this saves the current state of the game ###
  def save_game 
    save_state =File.open("storedData/game_state.json", "w")
    save_state.puts JSON.dump({
      :letters_left => @@letters_left,
      :gallow_count => @@gallow_count,
      :current_word => @@current_word,
      :current_word_hidden => @@current_word_hidden
    })
    save_state.close
  end
  
### this opens the current saved game###  
  def open_saved
    open_state = File.open("storedData/game_state.json", "r")
      data = JSON.load open_state
      @@letters_left = data["letters_left"]
      @@gallow_count = data["gallow_count"]
      @@current_word = data["current_word"]
      @@current_word_hidden = data["current_word_hidden"]
  end
    
###returns a word picked from a wordlist file###
  def game_word 
    wordbank = []
    textbase = File.readlines "storedData/5desk.txt"
    textbase.each do |word|
      if word.length > 5 && word.length < 12
        wordbank << word
      end
    end
    wordbank[rand(wordbank.length)] 
  end

### this shows the current state of the gallows with the hangman on it ###
  def gallows
    IO.readlines("gallows.txt")[(@@gallow_count * 7)..(@@gallow_count * 7) + 6]
  end

###This takes input from the player and checks if its a right or wrong guess###
  def player_turn
    puts gallows
    puts @@letters_left
    puts @@current_word_hidden
    puts "What is your next guess"
    guess = gets.chomp.upcase
    if guess == 'SAVE'
      save_game
      puts "Game Saved.  \n What is your next guess?"
      guess = gets.chomp.upcase
    end
    @@letters_left.gsub!(guess, "_")
    if @@current_word.include?(guess)
      index_marker = (0 ... @@current_word.length).find_all { |letters| @@current_word[letters,1] == guess}
      index_marker.each do |index|
        @@current_word_hidden[index] = guess
      end
    else
      @@gallow_count += 1
    end 
  end 
  
###checks to see if the player has lost by seeing how many wrong guesses have been made###  
  def game_over_check
    if @@gallow_count >= 6
      return true
    end
  end 

###iterates through the steps of taking turns and checking for win/loss ###  
  def game_play
    while @@current_word_hidden.include? "-"
      player_turn
      unless @@current_word_hidden.include? "-"
        puts @@current_word 
        puts "You Win"
      end
      if game_over_check
        puts "Game over.  You lose. The word was #{@@current_word}"
        @@current_word_hidden = @@current_word
        open_sequence
      
      end
    end
  end 
end



a = Hangman.new
a.open_sequence
