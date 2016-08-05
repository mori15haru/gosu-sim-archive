#particle.rb
require 'gosu'
class Particle
  def initialize(initial_status, window, t)
    # given status
    @x, @y, @v_x, @v_y, @a_x, @a_y = initial_status
    @x_boundry = window.width
    @y_boundry = window.height
    @t = t
    # fixed status
    @colour = Gosu::Color::WHITE
    @size = 10
  end

  def update
    update_velocity
    update_position
    boundry_check
  end

  def draw
    Gosu::draw_rect(@x, @y, @size, @size, @colour)
  end

  private

  def boundry_check
    x_boundry_check
    y_boundry_check
  end

  def update_velocity
    @v_x += @a_x * @t
    @v_y += @a_y * @t
  end

  def update_position
    @x += @v_x * @t
    @y += @v_y * @t
  end

  def x_outside_boundry?
    @x < 0 || @x > @x_boundry
  end

  def y_outside_boundry?
    @y < 0 || @y > @y_boundry
  end

  def x_boundry_check
    if x_outside_boundry?
      # velocity_resolution
      @v_x = -@v_x
      # position resolution
      if @x < 0
        @x = -@x
      else
        @x = 2 * @x_boundry - @x
      end
    end
  end

  def y_boundry_check
    if y_outside_boundry?
      # velocity_resolution
      @v_y = -@v_y
      # position resolution
      if @y < 0
        @y = -@y
      else
        @y = 2 * @y_boundry - @y
      end
    end
  end
end
