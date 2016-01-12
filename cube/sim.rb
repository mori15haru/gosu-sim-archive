#sim.rb
require 'gosu'
require './cube'

class SimWindow < Gosu::Window
  @@w = 640
  @@h = 480
  @@theta = 45 * Math::PI / 180 

  def initialize
    super @@w, @@h
    self.caption = "Ruby :: Gosu :: Cube"
    @cube = Cube.new
  end

  def update
  end

  def draw
    @cube.display 
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KbJ # along +x
      @cube.rotate_x(@@theta)
    elsif id == Gosu::KbK # along -x
      @cube.rotate_x(-@@theta)
    elsif id == Gosu::KbH # along +y
      @cube.rotate_y(@@theta)
    elsif id == Gosu::KbL # along -y
      @cube.rotate_y(-@@theta)
    elsif id == Gosu::KbA # along +z
      @cube.rotate_z(@@theta)
    elsif id == Gosu::KbS # along -z
      @cube.rotate_z(-@@theta)
    end
  end

end

window = SimWindow.new
window.show
