#sim.rb
require 'gosu'

module Shape
  module State
    Fall = :fall
    Still = :still
  end

  class IBlock
    N = 2

    include State

    def initialize
      @x = 200
      @y = 0
      @stage = 0
      @colour = Gosu::Color::WHITE
      @state = State::Fall
    end

    def falling?
      @state == State::Fall
    end

    def fall
      @y += 5
    end

    def boundry_check
      @state = State::Still if @y >= 400
    end

    def rotate
      @stage = (@stage + 1) % N if @state == State::Fall
    end

    def shapes
      {
        0 => [[-2,0], [-1,0], [0,0], [1,0]],
        1 => [[0,1], [0,0], [0,-1], [0,-2]]
      }
    end

    def draw
      shapes.fetch(@stage).each do |pix|
        Gosu::draw_rect(10 * pix[0] + @x, 10 * pix[1] + @y, 10, 10, @colour)
      end
    end
  end

  class JBlock
  end

  class LBlock
  end

  class OBlock
  end

  class SBlock
  end

  class TBlock
  end

  class ZBlock
  end
end

class SimWindow < Gosu::Window
  module Shapes
    I, J, L, O, S, T, Z = 0, 1, 2, 3, 4, 5, 6
  end

  @@w = 500
  @@h = 500

  include Shapes

  def initialize
    super @@w, @@h
    self.caption = 'Ruby :: Gosu :: Tetris'
    @block = Shape.const_get("#{shuffle}Block").new
    @blocks = [@block]
  end

  def shuffle
    'I'
  end

  def update
    @blocks.select(&:falling?).each do |b|
      b.boundry_check
      b.fall
    end
  end

  def draw
    @blocks.each { |b| b.draw }
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KbJ
      #@block.down
    elsif id == Gosu::KbK
      #@block.up
    elsif id == Gosu::KbH
      #@block.left
    elsif id == Gosu::KbL
      #@block.right
    elsif id == Gosu::KbSpace
      #@block.drop
    elsif id == Gosu::KbI
      @block.rotate
    end
  end

end

if __FILE__ == $0
  window = SimWindow.new
  window.show
end
