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
require './visualise'
require './initialise'

class SimWindow < Gosu::Window
  @@w = 500
  @@h = 500

  include Visualise
  include Initialise

  def initialize
    super @@w, @@h
    self.caption = 'Ruby :: Gosu :: Tetris'

    @initial_block = random_block
    @blocks = [@initial_block]
    @blocked_blocks = []
    @timer = 0.0
  end

  def blocked
    boundry + @blocked_blocks
  end

  def random_block
    Block.const_get("#{shuffle}Block").new
  end

  def boundry
    @boundry ||= right + left + bottom
  end

  def shuffle
    ['I', 'J', 'L', 'O', 'T', 'Z', 'S'].sample
  end

  def free?(key)
    !current_block.next(key).any? { |pix| blocked.compact.include?(pix) }
  end

  def clear
    y_to_clear = []

    @blocked_blocks.group_by { |b| b[1] }.each do |y, blocks_on_y|
      if blocks_on_y.size >= 21
        blocks_on_y.each do |pix|
          @blocked_blocks.delete(pix)
        end
        y_to_clear << y
      end
    end

    y_to_clear.each do |clear_y|
      @blocked_blocks.map! do |b|
        if b[1] < clear_y
          [b[0], b[1] + 10]
        else
          b
        end
      end
    end
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
          current_block.move(:up) if free?(:up)
        when 'h'
          current_block.move(:left) if free?(:left)
        when 'l'
          current_block.move(:right) if free?(:right)
        when 'i'
          current_block.move(:rotate) if free?(:rotate)
        end
      end

      @blocks.select(&:falling?).each do |b|
        if b.next(:fall).any? { |pix| blocked.compact.include?(pix) }
          b.change_to_still
          @blocked_blocks += b.pixels
          clear
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

  def current_block
    @blocks.select(&:falling?).first
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
