require 'set'
require_relative 'player'
require 'byebug'

class Game

  attr_reader :player1, :player2, :current_player, :fragment, :dictionary

  def initialize(*players)
    @players = players

    @fragment = ""

    @dictionary = File.readlines("dictionary.txt").to_set
    clean_dictionary
    @current_player = @players.first
    @losses = Hash.new(0)
  end

  def clean_dictionary
    @dictionary.map!(&:chomp)
  end

  def run
    until game_over?
      play_round
      eliminate_players
    end
    puts "#{@players.first.name} wins!"
  end

  def eliminate_players
    loser = @players.select { |p| @losses[p] == 5 }
    unless loser.empty?
      puts "#{loser.first.name} is out!"
      @players -= loser
    end
  end

  def play_round
    until round_over?
      take_turn
      next_player!
    end
    puts "#{@players.last.name} lost!"
    @fragment = ''
    @losses[@players[-1]] += 1
    display_standings
  end

  def take_turn
    valid = false
    until valid
      @current_player.display_fragment(@fragment)
      current_guess = @current_player.guess
      valid = valid_play?(current_guess)
      @current_player.alert_invalid_guess unless valid
    end
    @fragment << current_guess
  end

  def valid_play?(guess)
    guess.length == 1 && ("a".."z").cover?(guess) &&  possible_move?(guess) 
  end

  def possible_move?(guess)
    test_frag = @fragment.dup + guess
    @dictionary.each do |word|
      return true if word[0...test_frag.length] == test_frag
    end
    false
  end

  def next_player!
    @current_player = @players.rotate!.first
  end

  def round_over?
    @dictionary.include?(@fragment)
  end

  def game_over?
    @players.size == 1
  end

  def display_standings
    @players.each { |player| display_record(player) }
  end

  def display_record(player)
    ghost = %w[G H O S T]
    if @losses.keys.include?(player)
      puts "#{player.name} - #{ghost[0...@losses[player]].join('')}"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  p1 = Player.new('P1')
  p2 = Player.new('P2')
  p3 = AiPlayer.new
  new_game = Game.new(p1, p2, p3)
  new_game.run
end
