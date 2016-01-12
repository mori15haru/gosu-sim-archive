#cube.rb
require 'gosu'
class Rotation 
  def initialize(theta)
    @theta = theta
    
    @mMATRIX_X =
      [
        [1,   0,    0],
        [0, cos, -sin],
        [0, sin,  cos]
      ]

    @mMATRIX_Y =
      [
        [ cos, 0, sin],
        [   0, 1,   0],
        [-sin, 0, cos]
      ]

    @mMATRIX_Z =
      [
        [cos, -sin, 0],
        [sin,  cos, 0],
        [  0,    0, 1]
      ]
  end

  def x(v)    
    @mMATRIX_X.map{|u| u.zip(v).map{|i, j| i*j}.inject(:+)} 
  end

  def y(v)
    @mMATRIX_Y.map{|u| u.zip(v).map{|i, j| i*j}.inject(:+)} 
  end

  def z(v)
    @mMATRIX_Z.map{|u| u.zip(v).map{|i, j| i*j}.inject(:+)} 
  end

  private

  def cos
    Math::cos(@theta)
  end

  def sin
    Math::sin(@theta)
  end
end

class Vector
  def initialize(array)
    @v = array
    @rotation = Rotation.new(0.0)
  end

  def rotate_x(r)
    r.x(@v)
  end

  def rotate_y(r)
    r.y(@v)
  end

  def rotate_z(r)
    r.z(@v)
  end
  # Rotation
end

class Cube
  FROM = 0
  TO = 1

  @@l = 50
  @@edges = [
    [0, 1],
    [1, 3],
    [2, 3],
    [0, 2],
    [2, 6],
    [6, 7],
    [3, 7],
    [0, 4],
    [1, 5],
    [4, 5],
    [5, 7],
    [4, 6]
  ]
  @@colour = Gosu::Color::WHITE

  def initialize
    @vertices = [-@@l, @@l].repeated_permutation(3).to_a
  end

  def rotate_x(theta)
    rotation = Rotation.new(theta)
    @vertices.map!{|v| Vector.new(v).rotate_x(rotation)}
  end

  def rotate_y(theta)
    rotation = Rotation.new(theta)
    @vertices.map!{|v| Vector.new(v).rotate_y(rotation)}
  end

  def rotate_z(theta)
    rotation = Rotation.new(theta)
    @vertices.map!{|v| Vector.new(v).rotate_z(rotation)}
  end

  def display
    #vertices
    @vertices.each{|v| display_vertex(v)}
    #edges
    @@edges.each{|e| display_edge(@vertices[e[FROM]], @vertices[e[TO]])}
  end

  private

  def display_vertex(v)
    x = v[0] + 320
    y = -v[1] + 240
    print "// X: #{x} Y: #{y} //" 
    Gosu::draw_rect(x, y, 5, 5, @@colour)
  end

  def display_edge(v, u)
    x1 = v[0] + 320
    y1 = -v[1] + 240

    x2 = u[0] + 320
    y2 = -u[1] + 240
    Gosu::draw_line(x1, y1, @@colour, x2, y2, @@colour) 
  end

end
