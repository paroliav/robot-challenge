
class Table
  attr_accessor :x, :y
  DIMENSION = 5

  def initialize
    self.x = DIMENSION
    self.y = DIMENSION
  end

  def valid?(coordinate)
    return false unless coordinate[:x] > -1 && coordinate[:x] < self.x
    return false unless coordinate[:y] > -1 && coordinate[:y] < self.y
    true
  end

end