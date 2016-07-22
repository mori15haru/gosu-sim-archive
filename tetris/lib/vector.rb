class Vec
  attr_accessor :x, :y

  def initialize(arr)
    @x, @y = arr
  end

  def arr
    [@x, @y]
  end
  # -A
  def -@
    self*-1
  end
  # A + B
  def +(other)
    Vec.new(arr.zip(other.arr).map{|i,j| i+j})
  end
  # A - B
  def -(other)
    self + (-other)
  end
  # A * k
  def *(other)
    Vec.new(arr.map{|e| e*other})
  end
 end
