module Visualise
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
    show_boundry
    show_blocks
    show_blocked_blocks
    show_grid
  end

  def show_blocks
    @blocks.select(&:falling?).each { |b| b.draw }
  end

  def show_blocked_blocks
    @blocked_blocks.each do |b|
      Gosu::draw_rect(b[0], b[1], 10, 10, Gosu::Color::CYAN)
    end
  end

  def show_boundry
    boundry.each do |b|
      Gosu::draw_rect(b[0], b[1], 10, 10, Gosu::Color::GRAY)
    end
  end
end
