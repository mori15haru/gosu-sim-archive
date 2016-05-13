class SBlock < Block::Block
  def shapes
    {
      0 => [[0,0], [-1,0], [0,-1], [1,-1]],
      1 => [[0,0], [-1,0], [-1,-1], [0,1]]
    }
  end

  def colour
    Gosu::Color::AQUA
  end
end
