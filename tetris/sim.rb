#sim.rb

=begin
  1. push more than one steps - done
  2. game over? - done
  3. pix object? - done
  4. timing
  5. shadow? - done
  6. image?
  7. drop by space bar - done
=end

require 'gosu'
require './lib/block'
require './lib/blocks/i_block'
require './lib/blocks/j_block'
require './lib/blocks/l_block'
require './lib/blocks/o_block'
require './lib/blocks/s_block'
require './lib/blocks/t_block'
require './lib/blocks/z_block'
require './lib/move'
require './lib/visualise'
require './lib/initialise'
require './lib/update'
require './lib/visualise'

class SimWindow < Gosu::Window
  include Visualise
  include Initialise
  include Update::Generate
  include Update::Finish
  include Update::Clear
  include Update::ButtonInteraction
  include Update::Drop
  include Update::Check

  @@w = 500
  @@h = 500

  def initialize
    super @@w, @@h
    self.caption = 'Ruby :: Gosu :: Tetris'

    @drop_update_time = 200
    @drop_timer = 0.0

    @limit = 10
    @second_stage = false
    @double_button = nil
    @button = nil
    @blocks = []
    @blocked_blocks = []
  end

  def update
    # add a new block
    generate_block
    # button interaction
    button_interaction
    # drop block
    drop_block
  end
end

if __FILE__ == $0
  window = SimWindow.new
  window.show
end
