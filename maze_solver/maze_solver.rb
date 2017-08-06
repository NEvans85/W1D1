require_relative 'maze_node'

class MazeSolver

  attr_reader :start, :end
  def initialize(maze_file_path)
    @grid = parse_file(maze_file_path)
    @start = find('S')
    @end = find('E')
  end

private

  def parse_file(file_path)
    grid = File.readlines(file_path).chomp
    grid.map! { |row| row.split('') }
    grid
  end

  def find(char)
    @grid.each_with_index do |row, r_idx|
      row.each_with_index do |val, c_idx|
        return [r_idx, c_idx] if val == char
      end
    end
    raise "Maze does not contain #{char}"
  end

end
