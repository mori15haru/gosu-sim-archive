require './position'

class GameOfLife
  @@offsets = 
    [-1, 0, 1]
    .repeated_permutation(2)
    .to_a
    .delete_if{|p| p == [0, 0]}
    .map{|p| Position.new(p)}

  attr_accessor :cands, :alive_cells

  def initialize(initial_alive_cells)
    @alive_cells = initial_alive_cells
    @cands = nil
  end

  def update
    set_cands
    update_cells
    set_alive_cells
  end

  def to_s
    alive_cells_map.to_s
  end

  private

  def update_cells 
    @cands.each{|cell| cell.update_state(get_number_of_alive_neighbors(cell))}
  end

  def get_dead_cands
    alive_cells_pos
      .product(@@offsets)
      .map{|cand, offset| cand + offset}
      .map{|pos| pos.p}
      .uniq
      .select{|p| !alive_cells_map.include?(p)}
      .map{|p| Cell.new(CellState::DEAD, p)}
  end

  def set_cands
    @cands = alive_cells + get_dead_cands
  end

  def get_number_of_alive_neighbors(cell)
    @@offsets
      .map{|offset| cell.pos + offset}
      .select{|pos| alive_cells_map.include?(pos.p)}
      .count
  end

  def alive_cells_pos
    @alive_cells.map{|c| c.pos}
  end

  def alive_cells_map
    @alive_cells.map{|c| c.pos.p}
  end

  def set_alive_cells
    @alive_cells = @cands.select{|c| c.state == CellState::ALIVE}
  end

end