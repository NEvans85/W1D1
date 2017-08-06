class MazeNode

  attr_reader :value

  def intialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end

  def parent
    @parent
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent == node || @parent.nil?
    @parent = node
    @parent.cildren << self unless @parent.nil? || @parent.children.include?(self)
  end

end
