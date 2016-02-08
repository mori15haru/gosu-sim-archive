# display.rb
require './transformation'

module Display
  #####################################
  # Draw
  #####################################
  module Draw
    @@colour = Gosu::Color::WHITE

    def self.point(v)
      x, y, z = v
      Gosu::draw_rect(x, y, 5, 5, @@colour)
    end

    def self.line(v, u)
      x1, y1, z1 = v
      x2, y2, z2 = u

      Gosu::draw_line(x1, y1, @@colour, x2, y2, @@colour)
    end
  end

  #####################################
  # Display with perspective projection
  #####################################
  module Perspective
    def self.apply(v)
      return Transformation::Perspective::apply(v)
    end
  end

  #####################################
  # Display with orthographic projection
  #####################################
  module Orthographic
    def self.apply(v)
      return v
    end
  end

  ######################################
  # Convert to Gosu Coordinate
  ######################################
  module GosuCoordinate
    def self.convert(v)
      return Transformation::Coordinate::convert(v)
    end
  end

end
