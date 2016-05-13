module Block
  class Block
    module Move
      module Right
        def move
          @x += 10 if empty?
        end

        def empty?
          @x + 10 + 10 * x_min_max.fetch(@stage)[1] <= 300
        end

        def next
          pixels.map { |pix| [pix[0] + 10, pix[1]] }
        end
      end

      module Left
        def move
          @x -= 10 if empty?
        end

        def empty?
          @x - 10 + 10 * x_min_max.fetch(@stage)[0] >= 100
        end

        def next
          pixels.map { |pix| [pix[0] - 10, pix[1]] }
        end
      end

      module Up
        def move
          @y -= 10
        end

        def next
          pixels.map { |pix| [pix[0], pix[1] + 10] }
        end
      end

      module Down
        def move
          @y += 10
        end

        def next
          pixels.map { |pix| [pix[0], pix[1] + 10] }
        end
      end

      module Fall
        def move
          @y += 10
        end

        def next
          pixels.map { |pix| [pix[0], pix[1] + 10] }
        end
      end

      module Rotate
        def move
          @stage = (@stage + 1) % n if empty?
        end

        def next_stage
          (@stage + 1) % n
        end

        def empty?
          r_y_boundry_check && r_x_boundry_check
        end

        def next
          shapes.fetch(next_stage).map do |pix|
            [10 * pix[0] + @x, 10 * pix[1] + @y]
          end
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
end
