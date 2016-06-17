module Visualise

  SIZE = 10

  def show_grid
    c = Gosu::Color::GRAY

    (10..31).each do |w|
      draw_line(SIZE * w, SIZE, c, SIZE * w, SIZE * 40, c)
    end

    (10..40).each do |h|
      draw_line(SIZE * 10, h * SIZE, c, SIZE * 31, h * SIZE, c)
    end
  end

  def draw
    show_game_over_line
    show_boundry
    show_blocks
    show_shadow if current_block
    show_blocked_blocks
    show_grid
  end

  def draw_rect(pix, colour)
    render = pix * SIZE
    Gosu::draw_rect(render.x, render.y, SIZE, SIZE, colour)
  end

  def show_shadow
    current_block.shadow(blocked).draw(Gosu::Color::RED)
  end

  def show_blocks
    falling_blocks.each { |b| b.draw }
  end

  def show_blocked_blocks
    @blocked_blocks.each do |b|
      draw_rect(b, Gosu::Color::CYAN)
    end
  end

  def show_game_over_line
    game_over_line.each do |b|
      draw_rect(b, Gosu::Color::CYAN)
    end
  end

  def show_boundry
    boundry.each do |b|
      draw_rect(b, Gosu::Color::GRAY)
    end
  end
end
