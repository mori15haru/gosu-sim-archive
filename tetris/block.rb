require 'gosu'

module Block
  module State
    Fall = :fall
    Still = :still
  end

  class Block
    include State

    def initialize
      @x = 200
      @y = 0
      @stage = 0
      @state = State::Fall
    end

    def falling?
      @state == State::Fall
    end

    def fall
      @y += 10 if @state == State::Fall
    end

    def y_boundry_check
      if (@y + 10 + 10 * y_max.fetch(@stage)) >= 400
        @state = State::Still
        return pixels
      end
    end

    def x_left_check
      @x - 10 + 10 * x_min_max.fetch(@stage)[0] >= 100
    end

    def x_right_check
      @x + 10 + 10 * x_min_max.fetch(@stage)[1] <= 300
    end

    def right
      @x += 10 if @state == State::Fall && x_right_check
    end

    def left
      @x -= 10 if @state == State::Fall && x_left_check
    end

    def down
      @y += 10 if @state == State::Fall
    end

    def up
      @y -= 10 if @state == State::Fall
    end

    def rotate
      @stage = (@stage + 1) % n if @state == State::Fall
    end

    def change_to_still
      @state = State::Still
    end

    def next_pixels
      pixels.map { |pix| [pix[0], pix[1] + 10] }
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
