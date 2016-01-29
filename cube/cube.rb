#cube.rb
require 'gosu'

class Display
  @@colour = Gosu::Color::WHITE

  def self.point(v)
    delta = 400 /(v[2] + 200)
    x = delta * v[0] + 320
    y = delta * -v[1] + 240

    Gosu::draw_rect(x, y, 5, 5, @@colour)
  end

  def self.line(v, u)
    delta_v = 400 /(v[2] + 200)
    delta_u = 400 /(u[2] + 200)

    x1 = delta_v * v[0] + 320
    y1 = delta_v * -v[1] + 240

    x2 = delta_u * u[0] + 320
    y2 = delta_u * -u[1] + 240

    Gosu::draw_line(x1, y1, @@colour, x2, y2, @@colour)
  end

  private

  def convert_coordinate
  end

end

class DisplayProjection
  @@colour = Gosu::Color::WHITE

  def self.point(v)
    x =  v[0] + 320
    y = -v[1] + 240

    Gosu::draw_rect(x, y, 5, 5, @@colour)
  end

  def self.line(v, u)
    x1 =  v[0] + 320
    y1 = -v[1] + 240

    x2 =  u[0] + 320
    y2 = -u[1] + 240

    Gosu::draw_line(x1, y1, @@colour, x2, y2, @@colour)
  end

  private

  def convert_coordinate
  end

end

module Transformation
  class Rotation
    def initialize(theta)
      @theta = theta
    end

    def mMATRIX_X
        [
          [1,   0,    0],
          [0, cos, -sin],
          [0, sin,  cos]
      ]
    end

    def mMATRIX_Y
        [
          [ cos, 0, sin],
          [   0, 1,   0],
          [-sin, 0, cos]
      ]
    end

    def mMATRIX_Z
        [
          [cos, -sin, 0],
          [sin,  cos, 0],
          [  0,    0, 1]
      ]
    end

    def x(v)
      mMATRIX_X.map { |u| u.zip(v).map{|i, j| i*j}.inject(:+) }
    end

    def y(v)
      mMATRIX_Y.map { |u| u.zip(v).map{|i, j| i*j}.inject(:+) }
    end

    def z(v)
      mMATRIX_Z.map { |u| u.zip(v).map{|i, j| i*j}.inject(:+) }
    end

    def set_theta(theta_in_radian)
      @theta = theta_in_radian
    end

    private

    def cos
      Math::cos(@theta)
    end

    def sin
      Math::sin(@theta)
    end

  end
end

class Cube
  FROM = 0
  TO = 1

  @@l = 50
  @@edges = [
    [0, 1], [1, 3], [2, 3], [0, 2],
    [2, 6], [6, 7], [3, 7], [0, 4],
    [1, 5], [4, 5], [5, 7], [4, 6]
  ]

  def initialize
    @vertices = [-@@l, @@l].repeated_permutation(3).to_a
    @rotation = Transformation::Rotation.new(0.0)
    @perspective = true
    @display_method = method(:display_projection)
  end

  def rotate(axis, theta)
    @rotation.set_theta(theta)
    @vertices.map! { |v| @rotation.send(axis, v) }
  end

  def display
    @display_method.call
  end

  def display_perspective
    #vertices
    @vertices.each { |v| Display.point(v) }
    #edges
    @@edges.each { |e| Display.line(@vertices[e[FROM]], @vertices[e[TO]]) }
  end

  def display_projection
    #vertices
    @vertices.each { |v| DisplayProjection.point(v) }
    #edges
    @@edges.each { |e| DisplayProjection.line(@vertices[e[FROM]], @vertices[e[TO]]) }
  end

  def update_perspective
    @perspective = !@perspective 
    if @perspective
      @display_method = method(:display_perspective)
    else
      @display_method = method(:display_projection)
    end
  end

end
