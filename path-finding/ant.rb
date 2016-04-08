#particle.rb
require 'gosu'
class Ant
  attr_reader :x, :y

  def initialize(ground)
    @ground = ground

    @xi = 0
    @yi = 0

    @x = @xi
    @y = @yi

    @xf = 5
    @yf = 9 

    @colour_target = Gosu::Color::RED
    @colour = Gosu::Color::BLUE
  end

  def update
    if @x == @xf && @y == @yf
      return
    end

    next_pos = @ground.grid[[@x,@y]].next
    puts next_pos.inspect
    @x = next_pos[0]
    @y = next_pos[1]
  end

  def draw
    Gosu::draw_rect(@xf * 10, @yf * 10, 10, 10, @colour_target)
    Gosu::draw_rect(@x * 10, @y * 10, 10, 10, @colour)
  end
end
