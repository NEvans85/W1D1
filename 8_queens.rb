require 'byebug'
class ChessBoard

  attr_reader :board

  def initialize(board_size = 8)
    @board = Array.new(board_size) { Array.new(board_size) }
  end

  def []=(pos, value)
    x, y = pos
    @board[x][y] = value
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def nils
    nils = []
    @board.each_with_index do |row, r_idx|
      row.each_with_index { |sq, c_idx| nils << [r_idx, c_idx] if sq.nil? }
    end
    nils
  end

  def full?
    @board.none? { |row| row.any?(&:nil?) }
  end
end

class QueenNode

  attr_reader :x, :y

  def initialize(pos = [rand(8), rand(8)], parent = nil)
    @x, @y = pos
    @parent = parent
  end

  def possible_moves
    moves = []
    8.times do |i|
      moves << [x, i]
      moves << [i, y]
      moves << [x + i, y - i]
      moves << [x - i, y + i]
      moves << [x - i, y - i]
      moves << [x + i, y + i]
    end
    moves.select! do |pos|
      pos != [@x, @y] && (0...8).cover?(pos[0]) && (0...8).cover?(pos[1])
    end
    moves
  end

  def path_positions
    return possible_moves if @parent.nil?
    possible_moves + @parent.path_positions
  end

  def depth
    return 1 if @parent.nil?
    1 + @parent.depth
  end

  def bloodline_positions
    return [[@x, @y]] if @parent.nil?
    [[@x, @y]] + @parent.bloodline_positions
  end
end

class EightQueensSolver
  def initialize(board = ChessBoard.new)
    @board = board
  end

  def run
    @board = find_solution
    display_board
  end

  def display_board
    @board.board.each do |row|
      row.each { |sq| print "|#{sq}" }
      print "|\n"
    end
  end

  def find_solution(last_queen = QueenNode.new)
    board = ChessBoard.new
    unless last_queen.nil?
      last_queen.path_positions.each { |pos| board[pos] = '_' }
      last_queen.bloodline_positions.each { |pos| board[pos] = 'Q' }
      return board if last_queen.depth == 8
      return nil if board.full?
    end
    board.nils.shuffle.each do |nil_pos|
      solution = find_solution(QueenNode.new(nil_pos, last_queen))
      return solution unless solution.nil?
    end
    nil
  end

end
