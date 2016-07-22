require 'gosu'
require './lib/move'
require './lib/vector'

module Block
  module State
    Fall = :fall
    Still = :still
  end

  module Visualise
    SIZE = 10

    def draw_vec(pix, c)
      c = colour if c.nil?
      render = pix * SIZE
      Gosu::draw_rect(render.x, render.y, SIZE, SIZE, c)
    end
  end

  class Block
    include State
    include Move
    include Visualise

    attr_accessor :pos, :stage, :state

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

    def serialised_pos
      Vec.new([pos.x, pos.y].clone)
    end

    def shadow(blocked)
      self.class.new.tap do |block|
        block.pos = self.serialised_pos
        block.stage = self.stage
        block.state = self.state
        block.drop(blocked)
      end
    end

    def drop(blocked)
      while !self.next(:down).any? { |pix| blocked.map(&:arr).compact.include?(pix.arr) }
        self.move(:down)
      end
    end

    def draw(colour = nil)
      pixels.each do |pix|
        draw_vec(pix, colour)
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
