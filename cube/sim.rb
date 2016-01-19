#sim.rb
require 'gosu'
require './cube'

class SimWindow < Gosu::Window
  @@w = 640
  @@h = 480
  @@theta = 20 * Math::PI / 180

  def initialize
    super @@w, @@h
    self.caption = "Ruby :: Gosu :: Cube"

    @cube = Cube.new
    @perspective = true
  end

  def update
  end

  def draw
    if @perspective
      draw_perspective
    else
      draw_projection
    end
  end

  def draw_perspective
    @cube.display
  end

  def draw_projection
    @cube.display_projection
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KbJ # along +x
      @cube.rotate('x', @@theta)
    elsif id == Gosu::KbK # along -x
      @cube.rotate('x', -@@theta)
    elsif id == Gosu::KbH # along +y
      @cube.rotate('y', @@theta)
    elsif id == Gosu::KbL # along -y
      @cube.rotate('y', -@@theta)
    elsif id == Gosu::KbA # along +z
      @cube.rotate('z', @@theta)
    elsif id == Gosu::KbS # along -z
      @cube.rotate('z', -@@theta)
    elsif id == Gosu::KbP # perspective
      @perspective = !@perspective
    end
  end

end

window = SimWindow.new
window.show
