module Update
  module Generate
    def generate_block
      if falling_blocks.size < 1
        @blocks << random_block
      end
    end

    def shuffle
      ['I', 'J', 'L', 'O', 'T', 'Z', 'S'].sample
    end

    def random_block
      Block.const_get("#{shuffle}Block").new
    end
  end

  module Drop
    def drop_block
      return if !update_time?

      falling_blocks.each do |b|
        b.move(:fall)
      end
      @drop_timer = Gosu.milliseconds
    end
    
    def update_time?
      Gosu.milliseconds - @drop_timer > @drop_update_time
    end
  end

  module ButtonInteraction
    def button_interaction
      if current_block && @button
        if @button == :drop
          while free?(:down)
            current_block.move(:down)
          end
        else current_block && @button
          current_block.move(@button) if free?(@button)
        end
      end
      @button = nil
    end
    
    def double_button_interaction
    end
  
    def button_down(id)
      if id == Gosu::KbEscape
        close
      elsif id == Gosu::KbJ
        @button = :down
      elsif id == Gosu::KbK
        @button = :up
      elsif id == Gosu::KbH
        @double_button = @button if @button == :left
        @button = :left
      elsif id == Gosu::KbL
        @double_button = @button if @button == :right
        @button = :right
      elsif id == Gosu::KbW
        @button = :drop
      elsif id == Gosu::KbI
        @button = :rotate
      end
    end
  end

  module Clear
    def update_block
      falling_blocks.each do |b|
        if done?(b)
          b.change_to_still
          @blocked_blocks += b.pixels
          clear
          game_over
        end
      end
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
  end

  module Finish
    def game_over
      close if @blocked_blocks.map(&:y).any? { |y| y < @limit }
    end
  end

  module Check
    def current_block
      @blocks.select(&:falling?).first
    end

    def falling_blocks
      @blocks.select(&:falling?)
    end

    def done?(block)
      block.next(:fall).any? { |pix| blocked.map(&:arr).compact.include?(pix.arr) }
    end

    def blocked
      boundry + @blocked_blocks
    end

    def boundry
      @boundry ||= (right + left + bottom).map { |pix| Vec.new(pix) }
    end

    def free?(key)
      !current_block.next(key).any? { |pix| blocked.map(&:arr).compact.include?(pix.arr) }
    end
  end
end
