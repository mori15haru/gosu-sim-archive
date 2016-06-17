module Initialise
  #[9, 0]...[31, 0]#
  #................#
  #[9,39]...[31,39]#
  #[9,40]...[31,40]#
  ##################
  def right
    (1..40).map do |y|
      [31, 40 - y]
    end
  end

  def left
    (1..40).map do |y|
      [9, 40 - y]
    end
   end

  def bottom
    (1..23).map do |x|
      [8 + x, 40]
    end
  end
end
