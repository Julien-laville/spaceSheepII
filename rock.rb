require File.dirname(__FILE__)+'/utiles/points/Point.rb'
require File.dirname(__FILE__)+'/Convex_hull.rb'
require File.dirname(__FILE__)+'/Point_cloud.rb'
require File.dirname(__FILE__)+'/utiles/rectangle/Rectangle.rb'

class Rock
  attr_accessor :position, :collision, :agrandit, :points, :center
  def initialize
    @point_cloud = Point_cloud.new
    convex_hull = Convex_hull.new
    @points, @center = convex_hull.make_hull(@point_cloud.cloud)
    @position = Point.new(600, 0)
    @collision = Rectangle.new(@point_cloud.cloud)
    @collision.position = @position
    @collision.position.x = @position.x
  end
  
  def transit
    @position.x -= 1
  end
  def place y
    @position.y = y
    @collision.position.y = y
  end
  def set_agrandit polygon
    
    @agrandit = Rectangle.new
    @agrandit.position = @position
    @agrandit.position.x = @position.x
    @agrandit.position.y = @position.y
    @agrandit.minX = @collision.minX
    @agrandit.minY = @collision.minY
    @agrandit.maxX = @collision.maxX+polygon.maxX
    @agrandit.maxY = @collision.maxY+polygon.maxY
  end
  def draw_rock(window)
    pointtemp = @points.first
    #i = 0
    #@points1.each do |point|
    # window.draw_line(pointtemp.x+@position.x,pointtemp.y+@position.y,Gosu::Color.new(0xff0000FF),point.x+@position.x,point.y+@position.y,Gosu::Color.new(0xff0000FF))
    # pointtemp = point
    #  i += 1
    # end
    i = 0
    #window.draw_line(@points1.first.x+@position.x,@points1.first.y+@position.y,Gosu::Color.new(0xff0000FF),@points1.last.x+@position.x,@points1.last.y+@position.y,Gosu::Color.new(0xff0000FF))
    #draw_triangle (x1, y1, c1, x2, y2, c2, x3, y3, c3, z=0, mode=:default) 
    @points.each do |point|
      window.draw_triangle(pointtemp.x+@position.x,
                           pointtemp.y+@position.y,
                           Gosu::Color.new(0x33ffffff),
      point.x+@position.x,
      point.y+@position.y,
      Gosu::Color.new(0x33ffffff),
      60+@position.x,
      60+@position.y,
      Gosu::Color.new(0x33ffffff))
      pointtemp = point
      i += 1
    end
    window.draw_triangle(@points.first.x+@position.x,
                         @points.first.y+@position.y,
                         Gosu::Color.new(0x30ffffff),
    @points.last.x+@position.x,
    @points.last.y+@position.y,
    Gosu::Color.new(0x30ffffff),
    60+@position.x,
    60+@position.y,
    Gosu::Color.new(0x30ffffff))
    
    
    
    ############
    @points.each do |point|
      window.draw_triangle((pointtemp.x*0.9+@position.x)+10,
       (pointtemp.y*0.9+@position.y)+10,
      Gosu::Color.new(0xffffffff),
       (point.x*0.9+@position.x)+10,
       (point.y*0.9+@position.y)+10,
      Gosu::Color.new(0xffffffff),
       (100*0.9 + @position.x)+10,
       (100*0.9 + @position.y)+10,
      Gosu::Color.new(0xffffffff))
      pointtemp = point
      i += 1
    end
    window.draw_triangle((@points.first.x*0.9+@position.x)+10,
     (@points.first.y*0.9+@position.y)+10,
    Gosu::Color.new(0xffffffff),
     (@points.last.x*0.9+@position.x)+10,
     (@points.last.y*0.9+@position.y)+10,
    Gosu::Color.new(0xffffffff),
    100+@position.x+10,
    100+@position.y+10,
    Gosu::Color.new(0xffffffff))
     
   # draw_min(window)
    #  draw_rectangle window
  end
  def draw_min(window)
    min = @points.first
    points.each do |point|
      if point.y > min.y
        min = point 
      end     
    end
    window.draw_line(@position.x+min.x,
    @position.y+min.y,
    Gosu::Color.new(0xffff0000),
    @position.x+min.x+5,
    @position.y+min.y+5,
    Gosu::Color.new(0xffff0000))
    puts " - >#{min}" 
  end
  def draw_rectangle window
    window.draw_line(@collision.maxX+@collision.position.x,@collision.maxY+@collision.position.y,Gosu::Color.new(0xffff00ff),@collision.maxX+@collision.position.x,@collision.minY+@collision.position.y,Gosu::Color.new(0xffff00ff))
    window.draw_line(@collision.maxX+@collision.position.x,@collision.maxY+@collision.position.y,Gosu::Color.new(0xffff00ff),@collision.minX+@collision.position.x,@collision.maxY+@collision.position.y,Gosu::Color.new(0xffff00ff))
    window.draw_line(@collision.minX+@collision.position.x,@collision.minY+@collision.position.y,Gosu::Color.new(0xffff00ff),@collision.maxX+@collision.position.x,@collision.minY+@collision.position.y,Gosu::Color.new(0xffff00ff))
    window.draw_line(@collision.minX+@collision.position.x,@collision.minY+@collision.position.y,Gosu::Color.new(0xffff00ff),@collision.minX+@collision.position.x,@collision.maxY+@collision.position.y,Gosu::Color.new(0xffff00ff))
    
    window.draw_line(@agrandit.maxX+@agrandit.position.x,@agrandit.maxY+@agrandit.position.y,Gosu::Color.new(0xff00ffff),@agrandit.maxX+@agrandit.position.x,@agrandit.minY+@agrandit.position.y,Gosu::Color.new(0xff00ffff))
    window.draw_line(@agrandit.maxX+@agrandit.position.x,@agrandit.maxY+@agrandit.position.y,Gosu::Color.new(0xff00ffff),@agrandit.minX+@agrandit.position.x,@agrandit.maxY+@agrandit.position.y,Gosu::Color.new(0xff00ffff))
    window.draw_line(@agrandit.minX+@agrandit.position.x,@agrandit.minY+@agrandit.position.y,Gosu::Color.new(0xff00ffff),@agrandit.maxX+@agrandit.position.x,@agrandit.minY+@agrandit.position.y,Gosu::Color.new(0xff00ffff))
    window.draw_line(@agrandit.minX+@agrandit.position.x,@agrandit.minY+@agrandit.position.y,Gosu::Color.new(0xff00ffff),@agrandit.minX+@agrandit.position.x,@agrandit.maxY+@agrandit.position.y,Gosu::Color.new(0xff00ffff))
    
    
  end
  
  def to_s
    return "#{@position.x} | #{@position.y}"
  end
end