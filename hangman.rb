
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


puts game_word