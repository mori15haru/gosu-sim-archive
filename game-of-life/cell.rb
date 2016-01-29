require './cell_state'

class Cell
  ALIVE_TO_ALIVE = [2, 3]
  DEAD_TO_ALIVE  = 3

  attr_accessor :pos, :state, :n_neighbors

  def initialize(state, pos)
    @state = state
    @pos   = Position.new(pos)
  end

  def update_state(n_neighbors)
    @n_neighbors = n_neighbors
    if @state == CellState::ALIVE
      update_alive_cell
    else
      update_dead_cell
    end
  end

  private

  def update_dead_cell
    @state = CellState::ALIVE if DEAD_TO_ALIVE == n_neighbors
  end

  def update_alive_cell
    @state = CellState::DEAD unless ALIVE_TO_ALIVE.include?(n_neighbors)
  end

end