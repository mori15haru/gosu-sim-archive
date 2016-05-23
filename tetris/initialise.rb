module Initialise
  def right
    (1..30).map do |y|
      [80 + 10 * 23, 400 - y * 10]
    end
  end

  def left
    (1..30).map do |y|
      [80 + 10, 400- y * 10]
    end
   end

  def bottom
    (1..23).map do |x|
      [80 + 10 * x, 390 + 10]
    end
  end
end
