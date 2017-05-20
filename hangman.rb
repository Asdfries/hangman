class Hangman
  
  def initialize
    @@current_word
    @@letters_left = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
    @@gallow_count = 0
    @@current_word_hidden = String.new
  end

###This is the opening sequence for each game###
  def open_sequence
    display =  "   --------^ \n   |       | \n   O       | \n  /|\\      |   / \\      | \n           | \n __________|__"
    puts display
    puts "Welcome to Hangman!!! \nThe goal of the game here is to guess the secret word one letter at a time.\nEach mistake brings you closer to hanging our poor friend Disonoris Kagelbon. \nBegin by typing 'new', or open an existing game with 'open' " 
    decision = gets.chomp
    if decision = new
      new_game
    elsif decision = open
    
    end
  end
    
###returns a word picked from a wordlist file###
  def game_word 
    wordbank = []
    textbase = File.readlines "wordbank/5desk.txt"
    textbase.each do |word|
      if word.length > 5 && word.length < 12
        wordbank << word
      end
    end
    wordbank[rand(wordbank.length)] 
  end
  
### this saves the current state of the game ###
  def save_game 

  end

### this shows the current state of the gallows with the hangman on it ###
  def gallows
    IO.readlines("gallows.txt")[(@@gallow_count * 7)..(@@gallow_count * 7) + 6]
  end

  def player_turn
    puts gallows
    puts @@letters_left
    puts @@current_word_hidden
    puts "What is your next guess"
    guess = gets.chomp.upcase
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

  def game_status
  
  end 

###This resets the variables for a new game and assigns a new word to play with###
  def new_game
    @@current_word = game_word.upcase!
    (@@current_word.length - 1).times do 
      @@current_word_hidden << "-"
    end 
    @@gallow_count = 0
    @@letters_left = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
  end
  
  def game_over_check
    if @@gallow_count >= 6
      return "GAME OVER"
    end
  end 
  
  def game_play
    new_game
    while @@current_word_hidden.include? "-"
      player_turn
      game_over_check
    end
  end 
end
alpha = Hangman.new
alpha.game_play
