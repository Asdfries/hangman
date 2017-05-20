def game_word ###this uses a lists of words from a file and picks a word with an acceptible length ###
  wordbank = []
  textbase = File.readlines "wordbank/5desk.txt"
  textbase.each do |word|
    if word.length > 5 && word.length < 12
      wordbank << word
    end
  end
  wordbank[rand(wordbank.length)] 
end

def save_game ## this saves the current state of the game ###

end

