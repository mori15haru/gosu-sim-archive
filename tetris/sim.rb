#sim.rb

=begin
  1. push more than one steps - done
  2. game over?
  3. pix object? - done
  4. timing
  5. shadow?
  6. image?
  7. using space bar
=end

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

    @double_button = false
    @button = nil
    @blocks = []
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
    @boundry ||= (right + left + bottom).map { |pix| Vec.new(pix) }
  end

  def shuffle
    ['I', 'J', 'L', 'O', 'T', 'Z', 'S'].sample
  end

  def free?(key)
    !current_block.next(key).any? { |pix| blocked.map(&:arr).compact.include?(pix.arr) }
  end

  def clear
    y_to_clear = []

    @blocked_blocks.group_by(&:y).each do |y, blocks_on_y|
      if blocks_on_y.size >= 21
        blocks_on_y.each do |pix|
          @blocked_blocks.delete(pix)
        end
        y_to_clear << y
      end
    end

    @blocked_blocks.map! do |b|
      n = y_to_clear.count { |y| y > b.y }
      Vec.new([b.x, b.y + n])
    end
  end

  def update
    if update_time?
      # create new blocks
      if falling_blocks.size < 1
        @blocks << random_block
      end

      # key interactions with the current block
      if current_block && @button
        current_block.move(@button) if free?(@button)
        if @double_button
          current_block.move(@button) if free?(@button)
        end
      end

      falling_blocks.each do |b|
        if done?(b)
          b.change_to_still
          @blocked_blocks += b.pixels
          clear
        end
      end

      falling_blocks.each do |b|
        b.move(:fall)
      end

      @timer = Gosu.milliseconds
      @double_button = false
      @button = nil
    end
  end

  def done?(block)
    block.next(:fall).any? { |pix| blocked.map(&:arr).compact.include?(pix.arr) }
  end

  def falling_blocks
    @blocks.select(&:falling?)
  end

  def update_time?
    Gosu.milliseconds - @timer > 200
  end

  def current_block
    @blocks.select(&:falling?).first
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KbJ
      @button = :down
    elsif id == Gosu::KbK
      @button = :up
    elsif id == Gosu::KbH
      @double_button = true if @button == :left
      @button = :left
    elsif id == Gosu::KbL
      @double_button = true if @button == :right
      @button = :right
    elsif id == Gosu::KbW
      #block.drop
    elsif id == Gosu::KbI
      @button = :rotate
    end

  end
end

if __FILE__ == $0
  window = SimWindow.new
  window.show
end
