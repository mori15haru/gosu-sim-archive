#sim.rb
require 'gosu'
require './cube'

class SimWindow < Gosu::Window
  @@w = 640
  @@h = 480

  def initialize
    super @@w, @@h
    self.caption = "Ruby :: Gosu :: Cube"
    @cube = Cube.new
  end

  def update
  end

  def draw
    @cube.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

end

window = SimWindow.new
window.show
