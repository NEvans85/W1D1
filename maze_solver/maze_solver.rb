class MazeSolver

  attr_reader :start_pos, :end_pos, :grid
  def initialize(maze_file_path)
    parse_file(maze_file_path)
    @start_pos = find('S')
    @end_pos = find('E')
    @visited = []
  end

  def run
    path = find_path
    write_path(path) unless path.nil?
    display_maze
  end

  private

  def parse_file(file_path)
    @grid = File.readlines(file_path).map(&:chomp)
    @grid.map! { |row| row.split('') }
  end

  def display_maze
    @grid.each { |row| puts row.join('') }
  end

  def write_path(path)
    path.each { |pos| self[pos] = 'P' }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def find(char)
    @grid.each_with_index do |row, r_idx|
      row.each_with_index do |val, c_idx|
        return [r_idx, c_idx] if val == char
      end
    end
    raise "Maze does not contain #{char}"
  end

  def possible_moves(pos)
    neighbors = [[-1, 0], [0, 1], [1, 0], [0, -1]]
    neighbors.map! { |n_pos| [n_pos[0] + pos[0], n_pos[1] + pos[1]] }
    neighbors.reject { |n_pos| self[n_pos] == '*' }
  end

  def find_path(pos = @start_pos)
    @visited << pos
    return [pos] if pos == @end_pos
    possible_moves(pos).each do |move_pos|
      next if @visited.include?(move_pos)
      path = find_path(move_pos)
      return [pos] + path unless path.nil?
    end
    nil
  end

end
