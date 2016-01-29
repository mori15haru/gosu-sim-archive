class Position
  attr_accessor :p, :x, :y

  def initialize(pos)
    @p = pos
    @x = pos[0]
    @y = pos[1]
  end

  def +(other)
    Position.new([@x + other.x, @y + other.y])
  end

end