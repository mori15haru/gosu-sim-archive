require './game_of_life_sim'

if __FILE__ == $0
  window = SimWindow.new(ARGV[0].to_s)

  if ARGV[1].to_s == 'y'
    window.extend(Update)
  else
    window.extend(UpdateManual)
  end

  window.show
end