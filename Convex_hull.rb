require File.dirname(__FILE__)+'/Point_cloud.rb'
require File.dirname(__FILE__)+'/utiles/points/Point.rb'
#require File.dirname(__FILE__)+'/utiles/arrayList/arrayList.rb'
class Convex_hull 
  
  @hull

  def make_hull(point_cloud)
    #get one inner point
    
    center = barycentre(point_cloud[0],point_cloud[1],point_cloud[2])
    Convex_hull::make_angles(point_cloud,center)
    point_cloud = Convex_hull::sort_angles(center, point_cloud)
    save = point_cloud.clone
    min = miny point_cloud
    actualid = 0
    point_cloud = point_cloud + point_cloud.slice!(0..min-1)
    minp = point_cloud[min]
   cloud_size = point_cloud.size
   offset = cloud_size-actualid+1
 base_size = cloud_size + 1
    begin
    
      
      if Convex_hull.left_turn?(point_cloud[(actualid)%(cloud_size)],
        point_cloud[(actualid+1)%(cloud_size)],
        point_cloud[(actualid+2)%(cloud_size)])
        actualid += 1
        #puts "____________________________"
        #puts "actualid #{actualid}, min #{point_cloud.index min}"
      else
            
        point_cloud.delete_at((actualid+1)%(cloud_size))
        cloud_size -= 1
        
        actualid -= 1 
      #  actualid -= 1 if actualid == cloud_size
        #puts "droite"
      end      
     # puts "min #{point_cloud.index min}, truc #{point_cloud.index point_cloud[actualid%cloud_size]}"
   
 end while( actualid < base_size)
    #puts save.size
   
    return point_cloud,center
    
    
  end  
  def to_s
    return @hull.to_s
  end
  def testme(point_cloud)
    make_hull(point_cloud)
    
  end
  
  def barycentre(p1,p2,p3)
    return Point.new((p1.x+p2.x+p3.x) / 3.0,( p1.y+p2.y+p3.y )/ 3.0)
  end
  
  def self.make_angles(point_cloud,center)
    point_cloud.each do |point|
      point.angle = Convex_hull::get_angle point,center
    end
  end
  def self.get_angle point, center
    begin
        angle = Math.atan((point.y-center.y)/(point.x-center.x)) 
      rescue
        angle = 0.0000000001
    end
   return angle 
  end
  
  def self.sort_angles(center, point_cloud)
    points_right = []
    points_left = []
    point_cloud.each do |point|
      if point.x-center.x > 0
        points_right << point
      else
        points_left << point
      end
    end
    points_right.sort!
    points_left.sort!
    point_cloud = points_right + points_left
    return point_cloud
  end
  def miny tab
    min = tab.first
    tab.each do |point|
      if point.y > min.y
        min = point 
      end     
    end
    return tab.index(min)
    
  end
  
  def self.left_turn?(p1, p2, p3, pos1=Point.new(0,0), pos2=Point.new(0,0))
    angle = (((p2.x+pos1.x - p1.x+pos1.x)*(p3.y - p1.y+pos1.y)) - ((p3.x - p1.x+pos1.x)*(p2.y+pos1.y - p1.y+pos1.y)))      
    #puts p1.to_s + " "+ p2.to_s + " " + p3.to_s 
    return angle >= 0
  end
end
