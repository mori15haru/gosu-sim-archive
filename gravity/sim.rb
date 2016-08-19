#sim.rb
require 'gosu'
require './particle'
class SimWindow < Gosu::Window
  @@w = 640
  @@h = 480

  def initialize(n)
    # gosu variables
    super @@w, @@h
    self.caption = "Ruby :: Gosu :: Particle"
    #
    @t = 0.1
    @particles = []
    self.generate_particles(n)
  end

  def update
    @particles.each(&:update)
  end

  def draw
    @particles.each(&:draw)
  end

  def random_initial_status
    prng = Random.new
    # initial position
    x = prng.rand(@@w)
    y = prng.rand(@@h)
    # initial velocity
    vx = (-1)**x*prng.rand(30)
    vy = (-1)**y*prng.rand(30)
    # initial acceleration
    ax = 0
    ay = 9.8
    #
    [x, y, vx, vy, ax, ay]
  end

  def random_particle
    Particle.new(random_initial_status, self, @t)
  end

  def generate_particles(n)
    n.times { @particles << random_particle }
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

if __FILE__ == $0
  number_of_particles = ARGV[0].to_i
  SimWindow.new(number_of_particles).show
end
