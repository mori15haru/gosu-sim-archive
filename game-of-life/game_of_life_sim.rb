require 'gosu'
require './game_of_life'
require './cell'
require './cell_pattern'

module Update

  def update
    @game.update
    @cells = @game.alive_cells
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

end

module UpdateManual

  def upadte_cells
    @game.update
    @cells = @game.alive_cells
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KbSpace
      upadte_cells
    end
  end

end

class SimWindow < Gosu::Window

  @@w = 640
  @@h = 480
  @@zoom = 5.0

  def initialize(pattern)
    super @@w, @@h
    self.caption = "Ruby :: Gosu :: Game of Life"

    @cells = CellPattern.send(pattern)
    self.generate_cells
  end

  def draw
    @cells.each do |cell|
      Gosu::draw_rect(@@zoom*cell.pos.x, @@zoom*cell.pos.y, @@zoom , @@zoom, Gosu::Color::WHITE)
    end
  end

  def generate_cells
    @game = GameOfLife.new(@cells)
  end

end
