#sim.rb
require 'gosu'
require './particle'
class SimWindow < Gosu::Window
    @@w = 640
    @@h = 480
    @@t = 0.1
    def initialize(n)
        super @@w, @@h
        self.caption = "Ruby :: Gosu :: Particle"
        @particles = []
        self.generate_particles(n)   
    end

    def update
        @particles.each do |p|
            p.update
        end
    end

    def draw
        @particles.each do |p|
            p.draw
        end
    end
        
    def generate_particles(n)
        prng = Random.new
        n.times{
            x = prng.rand(@@w)
            y = prng.rand(@@h)
            vx = (-1)**x*prng.rand(30)
            vy = (-1)**y*prng.rand(30)
            ax = 0
            ay = 9.8
            @particles.push(Particle.new(x, y, vx, vy, ax, ay, @@w, @@h, @@t))
        }
    end

    def button_down(id)
        if id == Gosu::KbEscape
            close
        end
    end
end

window = SimWindow.new(ARGV[0].to_i)
window.show
