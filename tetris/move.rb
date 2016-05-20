module Block
  class Block
    module Move
      def move(key)
        case key
        when :right
          @x += 10 if empty?(key)
        when :left
          @x -= 10 if empty?(key)
        when :up
          @y -= 10
        when :down
          @y += 10
        when :fall
          @y += 10
        when :rotate
          @stage = (@stage + 1) % n if empty?(key)
        end
      end

      def empty?(key)
        case key
        when :right
          @x + 10 + 10 * x_min_max.fetch(@stage)[1] <= 300
        when :left
          @x - 10 + 10 * x_min_max.fetch(@stage)[0] >= 100
        when :rotate
          r_y_boundry_check && r_x_boundry_check
        end
      end

      def next(key)
        case key
        when :right
          pixels.map { |pix| [pix[0] + 10, pix[1]] }
        when :left
          pixels.map { |pix| [pix[0] - 10, pix[1]] }
        when :up
          pixels.map { |pix| [pix[0], pix[1] + 10] }
        when :down
          pixels.map { |pix| [pix[0], pix[1] + 10] }
        when :fall
          pixels.map { |pix| [pix[0], pix[1] + 10] }
        when :rotate
          shapes.fetch(next_stage).map do |pix|
            [10 * pix[0] + @x, 10 * pix[1] + @y]
          end
        end
      end

      def next_stage
        (@stage + 1) % n
      end

      def r_y_boundry_check
        @y + 10 + 10 * y_max.fetch(next_stage) < 400
      end

      def r_x_boundry_check
        @x + 10 * x_min_max.fetch(next_stage)[0] >= 100 &&
          @x + 10 * x_min_max.fetch(next_stage)[1] <= 300
      end
    end
  end
end
