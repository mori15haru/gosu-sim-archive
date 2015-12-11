#cube.rb
require 'gosu'

class Cube
  @@l = 5
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
  def initialize
    #[[-5, -5, -5], [-5, -5, 5], [-5, 5, -5], [-5, 5, 5], [5, -5, -5], [5, -5, 5], [5, 5, -5], [5, 5, 5]] 
    @nodes = [-@@l, @@l].repeated_permutation(3).to_a
  end
    
  def draw
    @@edges.each do |e|
      x1 = @nodes[e[0]][0]
      y1 = @nodes[e[0]][1]
      x2 = @nodes[e[1]][0]
      y2 = @nodes[e[1]][1]
      Gosu::draw_line(x1, y1, Gosu::Color::YELLOW, x2, y2, Gosu::Color::YELLOW)
    end
  end

end