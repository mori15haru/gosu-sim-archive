module Block
  class Block
    module Move

      def move(key)
        case key
        when :right
          @pos.x += 1
        when :left
          @pos.x -= 1
        when :up
          @pos.y -= 1
        when :down
          @pos.y += 1
        when :fall
          @pos.y += 1
        when :rotate
          @stage = next_stage
        end
      end

      def r_y_boundry_check
        max_y < 40
      end

      def r_x_boundry_check
        min_x >= 10 && max_x <= 30
      end

      def next(key)
        case key
        when :right
          pixels.map { |pix| pix + Vec.new([1,0]) }
        when :left
          pixels.map { |pix| pix + Vec.new([-1,0]) }
        when :up
          pixels.map { |pix| pix + Vec.new([0,-1]) }
        when :down
          pixels.map { |pix| pix + Vec.new([0,1]) }
        when :fall
          pixels.map { |pix| pix + Vec.new([0,1]) }
        when :rotate
          shapes.fetch(next_stage).fetch(:pixels).map do |pix|
            pix + @pos
          end
        end
      end

      def next_stage
        (@stage + 1) % n
      end

      def next_shape
        shapes.fetch(next_stage)
      end

      def max_y
        @pos.y + next_shape[:y_max] + 1
      end

      def min_x
        @pos.x + next_shape[:x_min]
      end

      def max_x
        @pos.x + next_shape[:x_max]
      end
    end
  end
end
