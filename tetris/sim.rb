#sim.rb
require 'gosu'
require './block'
require './blocks/i_block'
require './blocks/j_block'
require './blocks/l_block'
require './blocks/o_block'
require './blocks/s_block'
require './blocks/t_block'
require './blocks/z_block'
require './move'

class SimWindow < Gosu::Window
  @@w = 500
  @@h = 500

  def initialize
    super @@w, @@h
    self.caption = 'Ruby :: Gosu :: Tetris'
    @initial_block = Block.const_get("#{shuffle}Block").new
    @blocks = [@initial_block]
    @blocked = bottom
    @timer = 0.0
  end

  def bottom
    bottom = []
    (1..23).each do |x|
      bottom << [80 + 10 * x, 390 + 10]
    end
    return bottom
  end

  def shuffle
    ['I', 'J', 'L', 'O', 'T', 'Z', 'S'].sample
  end

  def update
    if update_time?
      # create new blocks
      if @blocks.select(&:falling?).size < 1
        @blocks << Block.const_get("#{shuffle}Block").new
      end

      # key interactions with the current block
      if current_block && current_block.falling?
        case @button
        when 'j'
          current_block.move(:down) if free?(:down)
        when 'k'
          current_block.move(:down) if free?(:up)
        when 'h'
          current_block.move(:left) if free?(:left)
        when 'l'
          current_block.move(:right) if free?(:right)
        when 'i'
          current_block.move(:rotate) if free?(:rotate)
        end
      end

      @blocks.select(&:falling?).each do |b|
        if b.next(:fall).any? { |pix| @blocked.compact.include?(pix) }
          b.change_to_still
          @blocked += b.pixels
        end
      end

      @blocks.select(&:falling?).each do |b|
        b.move(:fall)
      end

      @timer = Gosu.milliseconds
      @button = nil
    end
  end

  def update_time?
    Gosu.milliseconds - @timer > 100
  end

  def show_grid
    c = Gosu::Color::GRAY

    (10..31).each do |w|
      draw_line(10 * w, 10, c, 10 * w, 400, c)
    end

    (10..40).each do |h|
      draw_line(100, h*10, c, 310, h *10, c)
    end
  end

  def draw
    show_grid
    bottom.each do |b|
      Gosu::draw_rect(b[0], b[1], 10, 10, Gosu::Color::GRAY)
    end
    @blocks.each { |b| b.draw }
  end

  def current_block
    @blocks.select(&:falling?).first
  end

  def free?(key)
    !current_block.next(key).any? { |pix| @blocked.compact.include?(pix) }
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KbJ
      @button = 'j'
    elsif id == Gosu::KbK
      @button = 'k'
    elsif id == Gosu::KbH
      @button = 'h'
    elsif id == Gosu::KbL
      @button = 'l'
    elsif id == Gosu::KbSpace
      #@block.drop
    elsif id == Gosu::KbI
      @button = 'i'
    end
  end
end

if __FILE__ == $0
  window = SimWindow.new
  window.show
end
