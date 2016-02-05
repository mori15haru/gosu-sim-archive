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
