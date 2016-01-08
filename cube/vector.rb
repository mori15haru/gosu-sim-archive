class Vector
  class Rotation 
    MATRIX_X =
      [
        [1,   0,    0],
        [0, cos, -sin],
        [0, sin,  cos]
    ]

    MATRIX_Y =
      [
        [ cos, 0, sin],
        [   0, 1,   0],
        [-sin, 0, cos]
    ]

    MATRIX_Z =
      [
        [cos, -sin, 0],
        [sin,  cos, 0],
        [  0,    0, 1]
    ]

    def initialize(theta)
      @theta = theta
    end

    def x    
      MATRIX_X.map{|u| u.zip(v).map{|i, j| i*j}.inject(:+)} 
    end

    def y
      MATRIX_Y.map{|u| u.zip(v).map{|i, j| i*j}.inject(:+)} 
    end

    def z
      MATRIX_Z.map{|u| u.zip(v).map{|i, j| i*j}.inject(:+)} 
    end

    private

    def cos
      Math::cos(@theta)
    end

    def sin
      Math::sin(@theta)
    end
  end

  def initialize(array)
    @v = array
  end
end
