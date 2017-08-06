require_relative 'maze_node'

class MazeSolver

  attr_reader :start, :end
  def initialize(maze_file_path)
    @grid = parse_file(maze_file_path)
    @start = find('S')
    @end = find('E')
    # @move_tree = build_move_tree
  end

# private

  def parse_file(file_path)
    grid = File.readlines(file_path).map(&:chomp)
    grid.map! { |row| row.split('') }
    grid
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def find(char)
    @grid.each_with_index do |row, r_idx|
      row.each_with_index do |val, c_idx|
        return [r_idx, c_idx] if val == char
      end
    end
    raise "Maze does not contain #{char}"
  end

  def neighbors(pos)
    neighbors = [-1, 0, 1].product([-1, 0, 1])
    neighbors.map! { |n_pos| [n_pos[0] + pos[0], n_pos[1] + pos[1]] }
    neighbors.reject { |n_pos| n_pos == pos || self[n_pos].nil? }
  end

  def possible_moves(pos)
    neighbors(pos).select { |n_pos| self[n_pos] == ' ' }
  end

  def build_move_tree
    queue = [MazeNode.new(@start)]
    visited = []
    until queue.empty?
      visited << queue.shift
      return visited.last.path_trace if visited.last.position == @end
      possible_moves(visited.last.position).each do |pos|
    end
  end

end
