class IBlock < Block::Block
  def offsets
    {
      0 => [[-2,0], [-1,0], [0,0], [1,0]],
      1 => [[0,1], [0,0], [0,-1], [0,-2]]
    }
  end

  def colour
    Gosu::Color::RED
  end
end
