#sim.rb
require 'gosu'
require './cube'

class SimWindow < Gosu::Window
  @@w = 640
  @@h = 480
  @@theta = 25

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
    #elsif id == Gosu::KbH # along +y
    #elsif id == Gosu::KbL # along -y
    #elsif id == Gosu::KbA # along +z
    #elsif id == Gosu::KbS # along -z
    end
  end

end

window = SimWindow.new
window.show
