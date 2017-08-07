class MazeNode

  attr_reader :parent, :children, :position

  def initialize(pos, parent = nil)
    @position = pos
    self.parent = parent
    @children = []
  end

  def parent=(node)
    @parent.remove_child(self) unless @parent == node || @parent.nil?
    @parent = node
    @parent.children << self unless @parent.nil? ||
                                    @parent.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'NODE ERROR: not a child' unless @children.include?(child_node)
    child_node.parent = nil
  end

  # def dfs(target_value)
  #   return self if @value == target_value
  #   @children.each do |child|
  #     kid_search = child.dfs(target_value)
  #     return kid_search unless kid_search.nil?
  #   end
  #   nil
  # end
  #
  # def bfs(target_value)
  #   queue = [self]
  #   until queue.empty?
  #     el_to_test = queue.shift
  #     if el_to_test.value == target_value
  #       return el_to_test
  #     else
  #       queue += el_to_test.children
  #     end
  #   end
  #   nil
  # end

  # def depth
  #   return 1 if parent.nil?
  #   1 + parent.depth
  # end

  def path_trace
    return [@position] if parent.nil?
    [@position] + parent.path_trace
  end
end
