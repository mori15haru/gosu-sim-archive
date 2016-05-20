require 'gosu'
require './move'

module Block
  module State
    Fall = :fall
    Still = :still
  end

  class Block
    include State
    include Move

    def initialize
      @x = 200
      @y = 0
      @stage = 0
      @state = State::Fall
    end

    def falling?
      @state == State::Fall
    end

    def change_to_still
      @state = State::Still
    end

    def pixels
      shapes.fetch(@stage).map do |pix|
        [10 * pix[0] + @x, 10 * pix[1] + @y]
      end
    end

    def draw
      pixels.each do |pix|
        Gosu::draw_rect(pix[0], pix[1], 10, 10, colour)
      end
    end

    # important....
    # no hash...
    def y_max
      @y_max ||= shapes.map { |k, v| v.map { |e| e[1] }.max }
    end

    def x_min_max
      @x_min_max ||= shapes.map { |k, v| [v.map { |e| e[0] }.min, v.map { |e| e[0] }.max] }
    end

    def n
      @n ||= shapes.size
    end

  end
end
