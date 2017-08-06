class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def guess
    puts "#{@name} Guess a letter."
    gets.chomp
  end

  def alert_invalid_guess
    puts 'Invalid Guess!'
  end

  def display_fragment(fragment)
    puts fragment
  end

end

class AiPlayer

  attr_reader :name, :curr_fragment, :candidate_words

  def initialize(name = "CP")
    @name = name
    @candidate_words = File.readlines("dictionary.txt").to_set
    @candidate_words.map!(&:chomp)
  end

  def display_fragment(fragment)
    @curr_fragment = fragment
  end

  def losing_move?(guess)
    test_frag = @curr_fragment.dup + guess
    @candidate_words.include?(test_frag)
  end

  def guess
    letters = ("a".."z").to_a
    possible_guesses = letters.reject do |letter|
      losing_move?(letter) && !possible_move?(letter)
    end
    return possible_guesses.sample unless possible_guesses.empty?
    letters.select { |letter| possible_move?(letter) }.sample
  end

  def possible_move?(guess)
    test_frag = @curr_fragment.dup + guess
    @candidate_words.each do |word|
      return true if word[0...test_frag.length] == test_frag
    end
    false
  end

end

class BossAI < Player

  attr_reader :current_fragment

  def initialize(name = 'BOSS')
    @move_tree = []
    super(name)
  end

  def display_fragment(frag)
    @current_fragment == frag
  end

  def build_move_tree
  end
end
