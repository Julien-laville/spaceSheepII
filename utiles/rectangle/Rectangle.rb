require  File.dirname(__FILE__)+'/../points/Point.rb'
require File.dirname(__FILE__)+'/../../Collision.rb'
class Rectangle < Collision
  attr_accessor :maxY, :maxX, :minY, :minX
  def initialize cloud = nil
    unless cloud == nil
      maxY = minY = (cloud[0]).y
      maxX = minX = (cloud[0]).x
      cloud.each do |point|
        minY = point.y if  point.y < minY 
        minX = point.x if  point.x < minX 
        maxX = point.x if  point.x > maxX 
        maxY = point.y if  point.y > maxY 
      end 
      @maxY, @maxX, @minY, @minX = maxY, maxX, minY, minX 
    end
  end
 
  def contact?(r,x = nil, y = nil)
    tw = self.maxX-self.minX
    th = self.maxY-self.minY
    rw = r.maxX - r.minX
    rh = r.maxY - r.minY
    if (rw <= 0 || rh <= 0 || tw <= 0 || th <= 0) 
         return false;
    end
      tx = self.position.x;
      ty = self.position.y;
      rx = r.position.x;
      ry = r.position.y;
     rw += rx;
     rh += ry;
     tw += tx;
     th += ty;
     # thanks to Rectangle.java
 return ((rw < rx or rw > tx) and
         (rh < ry or rh > ty) and
         (tw < tx or tw > rx) and
         (th < ty or th > ry))
    
  end
  def to_s
    return "#{@minX} | #{@minY} | #{@maxX} | #{@maxY} :: #{x_position},#{y_position} "
  end
end