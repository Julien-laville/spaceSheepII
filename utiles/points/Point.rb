class Point
attr_accessor :y, :x, :angle
  def initialize(x = 0, y = 0, angle=0)
  @x = x
  @y = y
  @angle = angle
  end
  def to_s
    return "x = #{@x} | y = #{@y}"
  end
  def <=>(point) # Comparison operator for sorting
    @angle <=> point.angle
  end
  def +(point) # Comparison operator for sorting
    return Point.new @x + point.x, @y + point.y,point.angle
    
  end
  


end
