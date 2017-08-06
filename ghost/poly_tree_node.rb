require 'byebug'


class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def parent=(node)
    unless @parent == node || @parent.nil?
      @parent.children.delete(self)
    end
    @parent = node
    @parent.children << self unless @parent.nil? || @parent.children.include?(self)
  end

  def children
    @children
  end

  def value
    @value
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    unless @children.include?(child_node)
      raise 'Not one of mine!'
    end
    child_node.parent=(nil)
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      kid_search = child.dfs(target_value)
      return kid_search unless kid_search.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      el_to_test = queue.shift
      if el_to_test.value == target_value
        return el_to_test
      else
        queue += el_to_test.children
      end
    end

    nil
  end

end
