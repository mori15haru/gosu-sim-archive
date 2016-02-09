module CellPattern
  #Still lifes
  def self.block
    seeds = [
      [31,24], [32,24], [31,25], [32,25]
    ]

    seeds.map{|seed| Cell.new(CellState::ALIVE, seed)}
  end

  #Oscillator
  def self.blinker
    seeds = [
      [31,24], [32,24], [33,24]
    ]

    seeds.map{|seed| Cell.new(CellState::ALIVE, seed)}
  end

  def self.toad
    seeds = [
      [31,25], [32,25], [32,24],
      [33,25] [33,24], [34,24]
    ]

    seeds.map{|seed| Cell.new(CellState::ALIVE, seed)}
  end

  def self.beacon
    seeds = [
      [31,23], [32,23], [31,22], [32,22],
      [33,21], [34,21], [33,20], [34,20]
    ]

    seeds.map{|seed| Cell.new(CellState::ALIVE, seed)}
  end

  #Spaceships
  def self.glinder
    seeds = [
      [5,5], [3,6], [5,6], [4,7], [5,7]
    ]

    seeds.map{|seed| Cell.new(CellState::ALIVE, seed)}
  end

  def self.gosper_glider_gun
    seeds = [
      [10,25], [11,25], [10,26], [11,26],
      [20, 25], [20, 26], [20, 27],
      [21, 24], [21, 28],
      [22, 29], [23, 29],
      [22, 23], [23, 23],
      [24, 26], [25, 24], [25, 28],
      [26, 25], [26, 26], [26, 27],
      [27, 26],
      [30, 25], [31, 25], [30, 24], [31, 24], [30, 23], [31, 23],
      [32, 22], [34, 22], [34, 21],
      [32, 26], [34, 26], [34, 27],
      [44, 23], [45, 23], [44, 24], [45, 24]
    ]

    seeds.map{|seed| Cell.new(CellState::ALIVE, seed)}
  end
end
