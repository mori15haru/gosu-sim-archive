#sim.rb
require 'gosu'
require './cube'

if __FILE__ == $0
  window = SimWindow.new
  window.show
end

class SimWindow < Gosu::Window
  @@w = 640
  @@h = 480
  @@theta = 20 * Math::PI / 180

  def initialize
    super @@w, @@h
    self.caption = "Ruby :: Gosu :: Cube"

    @cube = Cube.new
  end

  # Not in use as it will update the cube by manually presing SPACE key 
  def update
  end

  def draw
    @cube.display
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
      update_perspective
    end
  end

  private

  def update_perspective
    @cube.update_perspective
  end

end
