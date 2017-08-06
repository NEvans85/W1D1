require_relative 'poly_tree_node'

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
    @candidate_words = File.readlines("dictionary.txt")
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

class BossAI < AiPlayer


  def initialize(name = 'BOSS')
    @move_tree = []
    super(name)
  end

  def build_move_tree(root)
    @move_tree = []
    parent = PolyTreeNode.new(root_value)
    kid_values = possible_moves(root_value.dup)
    kid_values.reject! { |chr| losing_move?(chr) }
    kid_values.each do |kid_value|
      kid = PolyTreeNode.new(kid_value)
      kid.parent = parent
    end
  end

  def guess

  end

  def possible_moves(str_frag)
    possible_words = @candidate_words.dup.select do |word|
      word[0...str_frag.length] == str_frag
    end
    possible_words.map { |word| word[str_frag.length] }.uniq
  end
end
