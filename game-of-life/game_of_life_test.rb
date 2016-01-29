c1 = Cell.new(CellState::ALIVE, [-1,0])
c2 = Cell.new(CellState::ALIVE, [0,0])
c3 = Cell.new(CellState::ALIVE, [1,0])

game = GameOfLife.new([c1,c2,c3])
puts 'Initial state: ' + game.to_s

5.times{
  game.update
  puts "NEXT..."
  puts game.to_s
}