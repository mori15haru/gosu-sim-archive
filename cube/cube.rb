#cube.rb
require 'gosu'
require './display'

###############
# Cube
###############
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
    @rotation = Transformation::Rotation
    @perspective = false
    @display = Display::Orthographic
  end

  def rotate(axis, theta)
    @rotation::set_theta(theta)
    @vertices.map! { |v| @rotation.apply(axis, v) }
  end

  def draw
    vertices_to_render = @vertices.map { |v| @display.apply(v) }
    vertices_to_gosu = vertices_to_render.map { |v| Display::GosuCoordinate::convert(v) }
    #vertices
    vertices_to_gosu.each { |v| Display::Draw::point(v) }
    #edges
    @@edges.each { |e| Display::Draw::line(vertices_to_gosu[e[FROM]], vertices_to_gosu[e[TO]]) }
  end

  def update_perspective
    @perspective = !@perspective
    if @perspective
      @display = Display::Perspective
    else
      @display = Display::Orthographic
    end
  end

end
