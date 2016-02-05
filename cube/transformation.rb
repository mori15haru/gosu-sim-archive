#################################
# Transformation matrices
#################################
module Transformation
  class Rotation
    def initialize(theta)
      @theta = theta
    end

    def mMATRIX_X
        [
          [1,   0,    0],
          [0, cos, -sin],
          [0, sin,  cos]
      ]
    end

    def mMATRIX_Y
        [
          [ cos, 0, sin],
          [   0, 1,   0],
          [-sin, 0, cos]
      ]
    end

    def mMATRIX_Z
        [
          [cos, -sin, 0],
          [sin,  cos, 0],
          [  0,    0, 1]
      ]
    end

    def x(v)
      mMATRIX_X.map { |u| u.zip(v).map{|i, j| i*j}.inject(:+) }
    end

    def y(v)
      mMATRIX_Y.map { |u| u.zip(v).map{|i, j| i*j}.inject(:+) }
    end

    def z(v)
      mMATRIX_Z.map { |u| u.zip(v).map{|i, j| i*j}.inject(:+) }
    end

    def set_theta(theta_in_radian)
      @theta = theta_in_radian
    end

    private

    def cos
      Math::cos(@theta)
    end

    def sin
      Math::sin(@theta)
    end

  end

  class Perspective
  end

end
