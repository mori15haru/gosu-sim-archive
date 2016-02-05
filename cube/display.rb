# display.rb
require './transformation'
#####################################
# Display with perspective projection
#####################################
class Display
  @@colour = Gosu::Color::WHITE

  def self.point(v)
    delta = 400 /(v[2] + 200)
    x = delta * v[0] + 320
    y = delta * -v[1] + 240

    Gosu::draw_rect(x, y, 5, 5, @@colour)
  end

  def self.line(v, u)
    delta_v = 400 /(v[2] + 200)
    delta_u = 400 /(u[2] + 200)

    x1 = delta_v * v[0] + 320
    y1 = delta_v * -v[1] + 240

    x2 = delta_u * u[0] + 320
    y2 = delta_u * -u[1] + 240

    Gosu::draw_line(x1, y1, @@colour, x2, y2, @@colour)
  end

  private

  def convert_coordinate
  end

end
######################################
# Display with orthographic projection
######################################
class DisplayProjection
  @@colour = Gosu::Color::WHITE

  def self.point(v)
    x =  v[0] + 320
    y = -v[1] + 240

    Gosu::draw_rect(x, y, 5, 5, @@colour)
  end

  def self.line(v, u)
    x1 =  v[0] + 320
    y1 = -v[1] + 240

    x2 =  u[0] + 320
    y2 = -u[1] + 240

    Gosu::draw_line(x1, y1, @@colour, x2, y2, @@colour)
  end

  private

  def convert_coordinate
  end

end
