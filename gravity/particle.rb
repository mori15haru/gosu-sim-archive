#particle.rb
require 'gosu'
class Particle
  def initialize(x, y, vx, vy, ax, ay, w, h, t)
    @x = x
    @y = y
    @v_x = vx
    @v_y = vy
    @a_x = ax
    @a_y = ay
    @x_boundry = w
    @y_boundry = h
    @t = t
    @colour = Gosu::Color::WHITE
  end

  def update
    @v_x += @a_x * @t
    @v_y += @a_y * @t
    @x += @v_x * @t
    @y += @v_y * @t
    if @x < 0 || @x > @x_boundry
      @v_x = -@v_x
      if @x < 0
        @x = -@x
      else
        @x = 2 * @x_boundry - @x
      end
    end
    if @y < 0 || @y > @y_boundry
      @v_y = -@v_y
      if @y < 0
        @y = -@y
      else
        @y = 2 * @y_boundry - @y
      end
    end
  end

  def draw
    Gosu::draw_rect(@x, @y, 10, 10, @colour)
  end
end
