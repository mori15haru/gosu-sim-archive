#sim.rb
require 'gosu'
require './block'
require './i_block'
require './j_block'
require './l_block'
require './o_block'
require './s_block'
require './t_block'
require './z_block'

class SimWindow < Gosu::Window
  @@w = 500
  @@h = 500

  def initialize
    super @@w, @@h
    self.caption = 'Ruby :: Gosu :: Tetris'
    @initial_block = Block.const_get("#{shuffle}Block").new
    @blocks = [@initial_block]
    @blocked = []
    @timer = 0.0
  end

  def shuffle
    ['I', 'J', 'L', 'O', 'T', 'Z', 'S'].sample
  end

  def update
    if @blocks.select(&:falling?).size < 1
      @blocks << Block.const_get("#{shuffle}Block").new
    end

    @blocks.select(&:falling?).each do |b|
      if b.y_boundry_check
        @blocked += b.y_boundry_check
      end
    end
    
    @blocks.select(&:falling?).each do |b|
      if b.next_pixels.any? { |pix| @blocked.compact.include?(pix) }
        b.change_to_still
        @blocked += b.pixels
      end
    end
   
    if Gosu.milliseconds - @timer > 1000
      @blocks.select(&:falling?).each do |b|
        b.fall
      end
      @timer = Gosu.milliseconds
    end
  end

  def draw
    @blocks.each { |b| b.draw }
  end

  def current_block
    @blocks.select(&:falling?).first
  end
  
  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KbJ
      current_block.down if current_block
    elsif id == Gosu::KbK
      current_block.up if current_block
    elsif id == Gosu::KbH
      current_block.left if current_block
    elsif id == Gosu::KbL
      current_block.right if current_block
    elsif id == Gosu::KbSpace
      #@block.drop
    elsif id == Gosu::KbI
      current_block.rotate if current_block
    end
  end

end

if __FILE__ == $0
  window = SimWindow.new
  window.show
end
