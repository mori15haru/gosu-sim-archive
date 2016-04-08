#sim.rb
require 'gosu'
require './ant'
require './ground'
class SimWindow < Gosu::Window
  @@w = 100 
  @@h = 100

  def initialize
    super @@w, @@h
    self.caption = "Ruby :: Gosu :: Path-finding"
    @ground = Ground.new
    @ant = Ant.new(@ground)
  end

  def update
  end

  def update_manually
    @ant.update
  end

  def draw
    @ground.draw
    @ant.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KbSpace
      update_manually
    end
  end
end

if __FILE__ == $0
  window = SimWindow.new
  window.show
end
