#################################
# Transformation matrices
#################################
module Transformation
  ######################################
  # Rotations
  ######################################
  module Rotation
    @theta = 0.0

    def self.mMATRIX_X
      [
        [1,   0,    0],
        [0, cos, -sin],
        [0, sin,  cos]
      ]
    end

    def self.mMATRIX_Y
      [
        [ cos, 0, sin],
        [   0, 1,   0],
        [-sin, 0, cos]
      ]
    end

    def self.mMATRIX_Z
      [
        [cos, -sin, 0],
        [sin,  cos, 0],
        [  0,    0, 1]
      ]
    end

    def self. x(v)
      mMATRIX_X.map { |u| u.zip(v).map{|i, j| i*j}.inject(:+) }
    end

    def self.y(v)
      mMATRIX_Y.map { |u| u.zip(v).map{|i, j| i*j}.inject(:+) }
    end

    def self.z(v)
      mMATRIX_Z.map { |u| u.zip(v).map{|i, j| i*j}.inject(:+) }
    end

    def self.set_theta(theta_in_radian)
      @theta = theta_in_radian
    end

    def self.cos
      Math::cos(@theta)
    end

    def self.sin
      Math::sin(@theta)
    end

  end

  ############################
  # Perspective
  ############################
  module Perspective
    @f = 0.0

    def self.mMATRIX
      [
        [@f,  0, 0],
        [ 0, @f, 0],
        [ 0,  0, 1]
      ]
    end

    def self.apply(v)
      set_f(v)
      mMATRIX.map { |u| u.zip(v).map{|i, j| i*j}.inject(:+) }
    end

    def self.set_f(v)
      @f = 400 / (v[2] + 200)
    end

  end

  ############################
  # Coordinate
  ############################
  module Coordinate
    def self.mMATRIX
      [
        [1,  0, 0, 320],
        [0, -1, 0, 240],
        [1,  0, 0,   0]
      ]
    end

    def self.convert(v)
      v = v << 1
      mMATRIX.map { |u| u.zip(v).map{|i, j| i*j}.inject(:+) }
    end
  end

end
