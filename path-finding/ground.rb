#particle.rb
require 'gosu'
class Ground
  attr_reader :grid

  @@world = (0..9).to_a.repeated_permutation(2)
  @@obstacles = [
  [0,3],[0,6],[0,9],
  [1,4],[1,6],[1,7],
  [2,0],[2,6],[2,7],
  [3,0],[3,6],[3,7],
  [4,5],[4,6],[4,7],
  [5,4],[5,5],[5,6],
  [6,0],[6,1],[6,2],
  [7,7],[7,8],[7,9],
  [8,3],[8,4],[8,5],
  [9,0],[9,1],[9,2]
  ] 

  def initialize
    @grid = {}
    set_grid
    set_neighbours_for_pedestrian
  end

  def update
  end

  def draw
    @grid.map { |pos, cell| cell.draw }
  end

  def set_grid
    @@world.to_a.each do |cell|
      if @@obstacles.include?(cell)
        @grid[cell] = Cell::Obstacle.new(cell)
      else
        @grid[cell] = Cell::Pedestrian.new(cell)
      end
    end
  end

  def set_neighbours_for_pedestrian
    @grid.each do |pos, cell|
      if cell.pedestrian?
        cell.set_neighbours(@grid)
      end
    end
  end
end

module Cell

  class Obstacle
    COLOUR = Gosu::Color::BLACK

    def initialize(cell)
      @x = cell[0]
      @y = cell[1]
    end

    def draw
      Gosu::draw_rect(@x * 10, @y * 10 , 10, 10, COLOUR)
    end

    def pedestrian?
      false
    end
  end

  class Pedestrian
    attr_reader :x, :y, :grid

    COLOUR = Gosu::Color::WHITE

    def initialize(cell)
      @x = cell[0]
      @y = cell[1]
    end

    def pedestrian?
      true
    end

    def draw
      Gosu::draw_rect(@x * 10, @y * 10, 10, 10, COLOUR)
    end

    def next
      neighbours.sample
    end

    def set_neighbours(grid)
      @grid = grid
    end

    def neighbours
      @neighbours ||= offsets.select { |h, v| (@x+h).between?(0,9) && (@y+v).between?(0,9) && @grid[[@x+h, @y+v]].pedestrian? }.map{ |h, v| [@x+h,@y+v] }
    end

    def offsets
      @offsets ||= [[1,0],[-1,0],[0,1],[0,-1]]
    end

  end
end
