require 'gosu'
require './move'
require './vector'

module Block
  module State
    Fall = :fall
    Still = :still
  end

  module Visualise
    SIZE = 10

    def draw_vec(pix)
      render = pix * SIZE
      Gosu::draw_rect(render.x, render.y, SIZE, SIZE, colour)
    end
  end

  class Block
    include State
    include Move
    include Visualise

    def initialize
      @pos = Vec.new([20, 0])
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
      shapes.fetch(@stage).fetch(:pixels).map do |pix|
        @pos + pix
      end
    end

    def draw
      pixels.each do |pix|
        draw_vec(pix)
      end
    end

    def shapes
      @shapes ||= offsets.each_with_object({}) do |(stage, pixels), hash|
        hash[stage] = {
          pixels: pixels.map { |pix| Vec.new(pix) },
          y_max: pixels.map { |pix| pix[1] }.max,
          y_min: pixels.map { |pix| pix[1] }.min,
          x_max: pixels.map { |pix| pix[0] }.max,
          x_min: pixels.map { |pix| pix[0] }.min
        }
      end
    end

    def n
      @n ||= shapes.size
    end
  end
end
